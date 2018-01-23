# docker-registry-s3
* Docker image to run private registry with S3 storage backend
* Environment vars support running registry in Mesos as Marathon App


## Run the docker reg 

*  docker run \
  -e AWS_BUCKET= <bucket-name> \
  -e AWS_KEY= <aws key>\
  -e AWS_SECRET= <aws secret key> \
  -e AWS_REGION="us-east-1" \
  -e STORAGE_PATH=/registry \
  -p 5000:5000 \
  ind9/registry-s3