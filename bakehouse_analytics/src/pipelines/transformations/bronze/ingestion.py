
from pyspark import pipelines as dp
from pyspark.sql import functions as F


SOURCES = {
    "transactions": "samples.bakehouse.sales_transactions",
    "customers": "samples.bakehouse.sales_customers",
    "franchises": "samples.bakehouse.sales_franchises",
    "suppliers": "samples.bakehouse.sales_suppliers",
    "reviews": "samples.bakehouse.media_customer_reviews",
}


def create_bronze_table(table_name: str, source_table: str):
    @dp.table(name=table_name)
    def bronze_table():
        return (
            spark.read.table(source_table)
            .withColumn("_ingestion_timestamp", F.current_timestamp())
        )

    return bronze_table


for table_name, source_table in SOURCES.items():
    create_bronze_table(table_name, source_table)