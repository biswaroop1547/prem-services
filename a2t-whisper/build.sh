#!/bin/bash

set -e

export VERSION=1.0.1

docker buildx build ${@:1} \
    --cache-from ghcr.io/premai-io/audio-to-text-whisper-tiny-cpu:latest \
    --file ./docker/cpu/Dockerfile \
    --build-arg="MODEL_ID=tiny" \
    --tag ghcr.io/premai-io/audio-to-text-whisper-tiny-cpu:latest \
    --tag ghcr.io/premai-io/audio-to-text-whisper-tiny-cpu:$VERSION \
    --platform linux/arm64,linux/amd64 .

docker run --rm ghcr.io/premai-io/audio-to-text-whisper-tiny-cpu:$VERSION pytest

docker buildx build ${@:1} \
    --cache-from ghcr.io/premai-io/audio-to-text-whisper-large-v2-gpu:latest \
    --file ./docker/gpu/Dockerfile \
    --build-arg="MODEL_ID=large-v2" \
    --tag ghcr.io/premai-io/audio-to-text-whisper-large-v2-gpu:latest \
    --tag ghcr.io/premai-io/audio-to-text-whisper-large-v2-gpu:$VERSION \
    .

docker run --rm ghcr.io/premai-io/audio-to-text-whisper-large-v2-gpu:$VERSION pytest
