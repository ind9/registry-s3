FROM registry:2.7.1

LABEL org.label-schema.vendor="Indix" \
    org.label-schema.name="registry-s3" \
    org.label-schema.description="Registry image with S3 storage configured for Marathon" \
    org.label-schema.usage="/src/README.md" \
    org.label-schema.url="https://github.com/ind9/registry-s3" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.docker.cmd.devel="" \
    org.label-schema.docker.params="AWS_BUCKET=S3 bucket name,\
    AWS_REGION=AWS Region to use,\
    AWS_KEY=Your account key,\
    AWS_SECRET=Your account secret,\
    STORAGE_PATH=S3 bucket directory to use" \
    org.label-schema.build-date=$build_date

ENV STORAGE_PATH="/" ENCRYPT=true SECURE=false

COPY distr-s3/docker-entrypoint.sh  /

RUN apk add --update python py-pip python-dev

RUN pip install awscli

ENTRYPOINT ["/docker-entrypoint.sh"]

COPY distr-s3/etc/docker/registry/config.yml /etc/docker/registry/config.yml

CMD ["/etc/docker/registry/config.yml"]
