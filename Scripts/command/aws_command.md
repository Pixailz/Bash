# ls bucket
aws s3 ls <bucket_name> --no-sign-request

# cp from bucket object
aws s3 cp s3://<bucket_name>/<object_name> . --no-sign-request

