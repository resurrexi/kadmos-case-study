# Kadmos Data Pipeline

## Pre-requisites

The instructions below assume that you have a Google Cloud project and are using an Ubuntu/Debian based machine with Google Cloud SDK installed and configured. If you do not have the SDK installed, please refer to the [installation docs](https://cloud.google.com/sdk/docs/install).

## Initial Setup

1. Clone the repo and `cd` into it.

    ```sh
    git clone git@github.com:resurrexi/kadmos-case-study.git
    cd kadmos-case-study
    ```

2. Create a storage bucket for your Google Cloud project. This will allow the downstream Postgres instance to be able to import files from the bucket. Let's assume the new bucket instance is called `kadmos-bucket`.

    ```sh
    gsutil mb gs://kadmos-bucket
    ```

3. Upload files from the `data` directory to the bucket.

    ```sh
    gsutil cp -r data gs://kadmos-bucket
    ```

4. Create a PostgreSQL instance for your Google Cloud project. Let's assume the instance is called `kadmos-pgdb` and the admin password is `kadmos`.

    ```sh
    gloud sql instances create kadmos-pgdb --database-version=POSTGRES_9_6 --cpu=1 --memory=4GB --root-password=kadmos
    ```

5. Once the PostgreSQL instance is created, retrieve its service account ID and grant it read permissions on the bucket. Replace `<PGDB_SERVICE_ACCOUNT_ID>` with the service account of the PostgreSQL instance.

    ```sh
    gsutil iam ch serviceAccount:<PGDB_SERVICE_ACCOUNT_ID>:objectViewer gs://kadmos-bucket
    ```

6. Create databases for the 3 data files:

    ```sh
    gcloud sql databases create aircrafts --instance=kadmos-pgdb
    gcloud sql databases create airports --instance=kadmos-pgdb
    gcloud sql databases create flights ---instance=kadmos-pgdb
    ```

7. Import schema/data files from `kadmos-bucket`:

    ```sh
    # import airports data
    gcloud sql import sql kadmos-pgdb gs://kadmos-bucket/data/airports.sql --database=airports --user=postgres

    # import flights data
    gcloud sql import sql kadmos-pgdb gs://kadmos-bucket/data/flights.sql --database=flights --user=postgres

    # create table for aircrafts data
    gcloud sql import sql kadmos-pgdb gs://kadmos-bucket/data/aircrafts_schema.sql --database=aircrafts --user=postgres
    # now import aircrafts data
    gcloud sql import csv kadmos-pgdb gs://kadmos-bucket/data/aircrafts.csv --database=aircrafts --table=aircrafts --user=postgres
    ```

8. Delete `kadmos-bucket`:

    ```sh
    gsutil rm -r gs://kadmos-bucket
    ```
