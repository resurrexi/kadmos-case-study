from datetime import datetime

from airflow import DAG
from airflow.operators.bash import BashOperator
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

with DAG(
    "aircrafts_etl",
    default_args=default_args,
    start_date=datetime.today(),
    schedule_interval="@once",
    catchup=False,
) as dag:
    download_csv = GCSToLocalFilesystemOperator(
        task_id="download_csv",
        object_name="aircrafts.csv",
        filename="{{ var.value.temp_dir }}/{{ run_id }}.csv",
        bucket="kadmos-data",
        gcp_conn_id="gcs_data",  # configure
    )
    process_csv = BashOperator(
        task_id="process_csv",
        bash_command=(
            "python {{ var.value.scripts_dir }}/transform_aircrafts.py"
            " --filename {{ run_id }}.csv"
        ),
    )
    upload_csv = LocalFilesystemToGCSOperator(
        task_id="upload_csv",
        src="{{ var.value.temp_dir}}/proc_{{ run_id }}.csv",
        dst="tables/aircrafts.csv",
        bucket="kadmos-data",
        gcp_conn_id="gcs_data",  # configure
    )
    create_bq_table = GCSToBigQueryOperator(
        task_id="create_bq_table",
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

    download_csv >> process_csv >> upload_csv >> create_bq_table
