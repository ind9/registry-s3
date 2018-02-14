#!/bin/sh

config_file=/etc/docker/registry/config.yml


if [ -z ${AWS_BUCKET+x} ]; then
    echo "Variable AWS_BUCKET is missing"
    failure=1
fi

if [ -z ${AWS_REGION+x} ]; then
    echo "Variable AWS_REGION is missing"
    failure=1
fi

if [ -z ${HTPASSWD_REALM+x} ]; then 
    echo "Env Variable HTPASSWD_REALM is missing"
    failure=1
fi

if [ -z ${HTPASSWD_PATH+x} ]; then
    echo "Env variable HTPASSWD_PATH is missing"
    failure=1
fi

if [ $failure == 1 ]; then
    exit 1
fi

aws s3 cp s3://$HTPASSWD_PATH/htpasswd /var/lib/htpasswd


cat $config_file | \
    sed "s@#STORAGE_PATH#@$STORAGE_PATH@g" |\
    sed "s@#AWS_BUCKET#@$AWS_BUCKET@g" |\
    sed "s@#AWS_REGION#@$AWS_REGION@g" |\
    sed "s@#AWS_KEY#@$AWS_KEY@g" |\
    sed "s@#AWS_SECRET#@$AWS_SECRET@g" |\
    sed "s@#ENCRYPT#@$ENCRYPT@g" |\
    sed "s@#SECURE#@$SECURE@g" |\
    sed "s@#HTPASSWD_REALM#@$HTPASSWD_REALM@g"  > /tmp/config-registry.yml


# Run the Docker CMD passed in
mv /tmp/config-registry.yml $config_file

exec /entrypoint.sh "$@"