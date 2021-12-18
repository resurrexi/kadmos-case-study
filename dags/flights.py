from datetime import datetime

from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.providers.google.cloud.operators.cloud_sql import (
    CloudSQLExportInstanceOperator,
)
from airflow.providers.google.cloud.transfers.gcs_to_local import (
    GCSToLocalFilesystemOperator,
)
from airflow.providers.google.cloud.transfers.local_to_gcs import (
    LocalFilesystemToGCSOperator,
)
from airflow.providers.google.cloud.transfers.gcs_to_bigquery import (
    GCSToBigQueryOperator,
)

default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "retries": 0,
}

# https://cloud.google.com/sql/docs/mysql/admin-api/rest/v1beta4/operations#ExportContext
airports_body = {
    "exportContext": {
        "fileType": "csv",
        "uri": "gs://kadmos-data/tables/airports.csv",
        "databases": ["airports"],
        "csvExportOptions": {"selectQuery": "SELECT * FROM airports_data"},
    }
}
flights_body = {
    "exportContext": {
        "fileType": "csv",
        "uri": "gs://kadmos-data/tables/flights.csv",
        "databases": ["flights"],
        "csvExportOptions": {"selectQuery": "SELECT * FROM flights"},
    }
}

with DAG(
    "flights_etl",
    default_args=default_args,
    start_date=datetime.today(),
    schedule_interval="@once",
    catchup=False,
) as dag:
    download_aircrafts_csv = GCSToLocalFilesystemOperator(
        task_id="download_aircrafts_csv",
        object_name="aircrafts.csv",
        filename="{{ var.value.temp_dir }}/{{ dag.dag_id }}-{{ run_id }}.csv",
        bucket="kadmos-data",
        gcp_conn_id="gcs_data",  # configure
    )
    process_aircrafts_csv = BashOperator(
        task_id="process_aircrafts_csv",
        bash_command=(
            "python {{ var.value.scripts_dir }}/transform_aircrafts.py"
            " --filename {{ dag.dag_id }}-{{ run_id }}.csv"
        ),
    )
    upload_aircrafts_csv = LocalFilesystemToGCSOperator(
        task_id="upload_aircrafts_csv",
        src="{{ var.value.temp_dir}}/proc_{{ dag.dag_id }}-{{ run_id }}.csv",
        dst="tables/aircrafts.csv",
        bucket="kadmos-data",
        gcp_conn_id="gcs_data",  # configure
    )
    create_aircrafts_bq_table = GCSToBigQueryOperator(
        task_id="create_aircrafts_bq_table",
        bucket="kadmos-data",
        source_objects=["tables/aircrafts.csv"],
        destination_project_dataset_table="flights.aircrafts",
        schema_fields=[
            {"name": "aircraft_code", "type": "STRING"},
            {"name": "model", "type": "STRING"},
            {"name": "range", "type": "INT64"},
        ],
        source_format="CSV",
        skip_leading_rows=1,
        create_disposition="CREATE_IF_NEEDED",
        write_disposition="WRITE_TRUNCATE",
        bigquery_conn_id="bq_owner",  # configure
        google_cloud_storage_conn_id="gcs_data",  # configure
    )
    export_airports_pg2gcs = CloudSQLExportInstanceOperator(
        task_id="export_airports_pg2gcs",
        instance="kadmos-pgdb",
        body=airports_body,
        gcp_conn_id="gcs_data",
    )
    create_airports_bq_table = GCSToBigQueryOperator(
        task_id="create_airports_bq_table",
        bucket="kadmos-data",
        source_objects=["tables/airports.csv"],
        destination_project_dataset_table="flights.airports",
        schema_fields=[
            {"name": "airport_code", "type": "STRING"},
            {"name": "airport_name", "type": "STRING"},
            {"name": "city", "type": "STRING"},
            {"name": "coordinates", "type": "STRING"},
            {"name": "timezone", "type": "STRING"},
        ],
        source_format="CSV",
        create_disposition="CREATE_IF_NEEDED",
        write_disposition="WRITE_TRUNCATE",
        bigquery_conn_id="bq_owner",  # configure
        google_cloud_storage_conn_id="gcs_data",  # configure
    )
    export_flights_pg2gcs = CloudSQLExportInstanceOperator(
        task_id="export_flights_pg2gcs",
        instance="kadmos-pgdb",
        body=flights_body,
        gcp_conn_id="gcs_data",
    )
    create_flights_bq_table = GCSToBigQueryOperator(
        task_id="create_flights_bq_table",
        bucket="kadmos-data",
        source_objects=["tables/flights.csv"],
        destination_project_dataset_table="flights.flights",
        schema_fields=[
            {"name": "flight_id", "type": "INT64"},
            {"name": "flight_no", "type": "STRING"},
            {"name": "scheduled_departure", "type": "TIMESTAMP"},
            {"name": "scheduled_arrival", "type": "TIMESTAMP"},
            {"name": "departure_airport", "type": "STRING"},
            {"name": "arrival_airport", "type": "STRING"},
            {"name": "status", "type": "STRING"},
            {"name": "aircraft_code", "type": "STRING"},
            {"name": "actual_departure", "type": "TIMESTAMP"},
            {"name": "actual_arrival", "type": "TIMESTAMP"},
        ],
        source_format="CSV",
        create_disposition="CREATE_IF_NEEDED",
        write_disposition="WRITE_TRUNCATE",
        bigquery_conn_id="bq_owner",  # configure
        google_cloud_storage_conn_id="gcs_data",  # configure
    )

    (
        download_aircrafts_csv
        >> process_aircrafts_csv
        >> upload_aircrafts_csv
        >> create_aircrafts_bq_table
    )
    export_airports_pg2gcs >> create_airports_bq_table
    export_flights_pg2gcs >> create_flights_bq_table
