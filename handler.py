import os
import boto3
from dotenv import load_dotenv, find_dotenv
from tempfile import NamedTemporaryFile
from worker import raster_shape
load_dotenv(find_dotenv())

libdir = os.path.join(os.getcwd(), 'local', 'lib')
s3_client = boto3.client('s3')

dst_bucket = SECRET_KEY = os.environ.get("DST_BUCKET")

def handler(event, context):
    results = []
    for record in event['Records']:

        # Find input/output buckets and key names
        bucket = record['s3']['bucket']['name']
        output_bucket = dst_bucket
        key = record['s3']['object']['key']
        output_key = "{0}.geojson".format(os.path.splitext(key)[0])

        # Download the raster locally
        with NamedTemporaryFile(suffix=".tif", delete=True) as download_path:
            s3_client.download_file(bucket, key, download_path.name)

            # Call the worker, setting the environment variables
            output_path = raster_shape(download_path.name)

            # Upload the output of the worker to S3
            s3_client.upload_file(output_path.strip(), output_bucket, output_key)
            results.append(output_path.strip())

    return results