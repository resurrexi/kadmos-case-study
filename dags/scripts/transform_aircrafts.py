import os
import argparse
import json
import csv

from airflow.models.variable import Variable


def get_file_path(filename):
    return os.path.join(Variable.get("temp_dir"), filename)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--filename", required=True)
    args = parser.parse_args()

    fieldnames = ["aircraft_code", "model", "range"]

    with open(get_file_path(args.filename), "r") as in_file:
        with open(get_file_path(f"proc_{args.filename}"), "w") as out_file:
            reader = csv.DictReader(in_file)
            writer = csv.DictWriter(out_file, fieldnames=fieldnames)

            writer.writeheader()
            for row in reader:
                ac = row["aircraft_code"]
                model = json.loads(row["model"])["en"]
                range = row["range"]

                writer.writerow(
                    {
                        "aircraft_code": ac,
                        "model": model,
                        "range": range,
                    }
                )
