import argparse

from pyspark.sql import functions as F


parser = argparse.ArgumentParser()
parser.add_argument("--catalog", required=True)
parser.add_argument("--schema", required=True)

args = parser.parse_args()

catalog = args.catalog
schema = args.schema


spark.sql(f"USE CATALOG `{catalog}`")
spark.sql(f"CREATE SCHEMA IF NOT EXISTS `{schema}`")
spark.sql(f"USE SCHEMA `{schema}`")


def ingest(catalog: str, schema: str):

    sources = {
        "transactionsx": "samples.bakehouse.sales_transactions",
        "customersx": "samples.bakehouse.sales_customers",
        "franchisesx": "samples.bakehouse.sales_franchises",
        "suppliersx": "samples.bakehouse.sales_suppliers",
        "reviewsx": "samples.bakehouse.media_customer_reviews",
    }

    for target_table, source_table in sources.items():

        df = (
            spark.read.table(source_table)
            .withColumn("_ingestion_timestamp", F.current_timestamp())
        )

        (
            df.write
            .format("delta")
            .mode("overwrite")
            .saveAsTable(f"{catalog}.{schema}.{target_table}")
        )


ingest(catalog, schema)