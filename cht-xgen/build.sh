#!/bin/bash

set -e

export VERSION=1.0.0

docker buildx build ${@:1} \
    --cache-from ghcr.io/premai-io/chat-xgen-7b-8k-inst-gpu:latest \
    --file ./docker/gpu/Dockerfile \
    --build-arg="MODEL_ID=Salesforce/xgen-7b-8k-inst" \
    --tag ghcr.io/premai-io/chat-xgen-7b-8k-inst-gpu:latest \
    --tag ghcr.io/premai-io/chat-xgen-7b-8k-inst-gpu:$VERSION \
    .
docker run --gpus all ghcr.io/premai-io/chat-xgen-7b-8k-inst-gpu:latest pytest
