# docker buildx create --use
docker buildx build . -t davidsiaw/ocs --platform linux/arm64,linux/amd64 --push
