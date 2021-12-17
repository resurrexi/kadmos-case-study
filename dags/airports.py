from datetime import datetime

from airflow import DAG
from airflow.providers.google.cloud.operators.cloud_sql import (
    CloudSQLExportInstanceOperator,
)
from airflow.providers.google.cloud.transfers.gcs_to_bigquery import (
    GCSToBigQueryOperator,
)

default_args = {"owner": "airflow", "depends_on_past": False, "retries": 0}

extract_sql = """
SELECT airport_code,
    airport_name->>'en' AS name_en,
    airport_name->>'ru' AS name_ru,
    city->>'en' AS city_en,
    city->>'ru' AS city_ru,
    coordinates[0] AS coordinates_x,
    coordinates[1] AS coordinates_y,
    timezone
FROM airports_data
"""
# https://cloud.google.com/sql/docs/mysql/admin-api/rest/v1beta4/operations#ExportContext
export_body = {
    "exportContext": {
        "fileType": "csv",
        "uri": "gs://kadmos-data/tables/airports.csv",
        "databases": ["airports"],
        "csvExportOptions": {"selectQuery": extract_sql},
    }
}

with DAG(
    "airports_etl",
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
        source_objects=["tables/airports.csv"],
        destination_project_dataset_table="flights.airports",
        schema_fields=[
            {"name": "airport_code", "type": "STRING"},
            {"name": "airport_name_en", "type": "STRING"},
            {"name": "airport_name_ru", "type": "STRING"},
            {"name": "city_en", "type": "STRING"},
            {"name": "city_ru", "type": "STRING"},
            {"name": "coordinates_x", "type": "FLOAT64"},
            {"name": "coordinates_y", "type": "FLOAT64"},
            {"name": "timezone", "type": "STRING"},
        ],
        source_format="CSV",
        create_disposition="CREATE_IF_NEEDED",
        write_disposition="WRITE_TRUNCATE",
        bigquery_conn_id="bq_owner",  # configure
        google_cloud_storage_conn_id="gcs_data",  # configure
    )

    export_to_gcs >> create_bq_table
