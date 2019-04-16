#!/bin/sh
set -e

if [ -f ~/.init-ran ]; then
    exit 0
fi

if [ -z "$GOOGLE_APPLICATION_CREDENTIALS" ]; then
    gcloud auth application-default login
    echo "export GOOGLE_CLOUD_KEYFILE_JSON=/home/charlie/.config/gcloud/application_default_credentials.json"

    gcloud auth login
    gcloud config set project invoice-213422
fi

touch ~/.init-ran