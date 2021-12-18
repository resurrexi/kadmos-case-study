from datetime import datetime

from airflow import DAG
from airflow.providers.google.cloud.operators.cloud_sql import (
    CloudSQLExportInstanceOperator,
)
from airflow.providers.google.cloud.transfers.gcs_to_bigquery import (
    GCSToBigQueryOperator,
)

default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "retries": 0,
}

extract_sql = """
SELECT *
FROM flights
"""

# https://cloud.google.com/sql/docs/mysql/admin-api/rest/v1beta4/operations#ExportContext
export_body = {
    "exportContext": {
        "fileType": "csv",
        "uri": "gs://kadmos-data/tables/flights.csv",
        "databases": ["flights"],
        "csvExportOptions": {"selectQuery": extract_sql},
    }
}

with DAG(
    "flights_etl",
    default_args=default_args,
    start_date=datetime.today(),
    schedule_interval="@once",
    catchup=False,
) as dag:
    export_to_gcs = CloudSQLExportInstanceOperator(
        task_id="export_to_gcs",
        instance="kadmos-pgdb",
        body=export_body,
        gcp_conn_id="gcs_data",
    )
    create_bq_table = GCSToBigQueryOperator(
        task_id="create_bq_table",
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

    export_to_gcs >> create_bq_table
