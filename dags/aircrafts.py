from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.providers.google.cloud.transfers.gcs_to_local import (
    GCSToLocalFilesystemOperator,
)
from airflow.providers.google.cloud.transfers.local_to_gcs import (
    LocalFilesystemToGCSOperator,
)


default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

with DAG(
    "aircrafts_etl",
    default_args=default_args,
    start_date=datetime.today(),
    schedule_interval="@once",
    catchup=False,
) as dag:
    download_file = GCSToLocalFilesystemOperator(
        task_id="download_csv",
        object_name="aircrafts.csv",
        filename="{{ var.value.temp_dir }}/{{ run_id }}.csv",
        bucket="kadmos-data",
        gcp_conn_id="gcs_data",  # configure via Admin > Connections
    )
    process_file = BashOperator(
        task_id="process_csv",
        bash_command=(
            "python {{ var.value.scripts_dir }}/transform_aircrafts.py"
            " --filename {{ run_id }}.csv"
        ),
    )
    upload_file = LocalFilesystemToGCSOperator(
        task_id="upload_csv",
        src="{{ var.value.temp_dir}}/proc_{{ run_id }}.csv",
        dst="tables/aircrafts.csv",
        bucket="kadmos-data",
        gcp_conn_id="gcs_data",  # configure via Admin > Connections
    )

    download_file >> process_file >> upload_file
