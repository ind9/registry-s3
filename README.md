# docker-registry-s3
* Docker image to run private registry with S3 storage backend
* configure environment vars(config.yml) run registry in Mesos as Marathon App



## Run the docker reg 

``` 
docker run \
  -e AWS_BUCKET= <bucket-name> \
  -e AWS_KEY= <aws key>\
  -e AWS_SECRET= <aws secret key> \
  -e AWS_REGION="us-east-1" \
  -e HTPASSWD_REALM="indix" \
  -e HTPASSWD_PATH= <aws bucket with htpasswd> \
  -e STORAGE_PATH=/registry \
  -p 5000:5000 \
  ind9/registry-s3
```

## CI for dockerhub

- Creating new tags with your commit will create automated builds in dockerhub.
- Tags follow format v1.0.2 (to trigger automated build rules)

### Create HTPasswd 

- htpasswd with Bcrypt is used for authenticating registry 2. Create the htpasswd file using command

  > htpasswd -Bc <file-name> username 

- The above command prompts you to enter password. Copy the file with label as htpasswd to s3-bucket 
  input as HTPASSWD_PATH. The object path would be Bucket-name/htpasswd