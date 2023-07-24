#!/bin/bash
set -e
export VERSION=1.0.0

docker buildx build ${@:1} \
    --file ./docker/cpu/Dockerfile \
    --build-arg="MODEL_ID=Salesforce/codet5p-220m-py" \
    --tag ghcr.io/premai-io/coder-codet5p-220m-py-cpu:latest \
    --tag ghcr.io/premai-io/coder-codet5p-220m-py-cpu:$VERSION \
    --platform linux/amd64 \
    .
docker run --rm ghcr.io/premai-io/coder-codet5p-220m-py-cpu:$VERSION pytest
