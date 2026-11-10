#!/bin/bash

# I'm not that familiar with docker. Send a PR if something is wrong (^.^)

BASE_DIR=$(realpath "$(dirname "${BASH_SOURCE[0]}")")
cd "$BASE_DIR" || exit 1
if [[ ! -d "$BASE_DIR/auth" ]]; then
    echo "Creating Auth Directory.."
	mkdir -p "$BASE_DIR/auth"
fi

CONTAINER="zphisher"
IMAGE="htrtech/zphisher:latest"
MOUNT_LOCATION=${BASE_DIR}/auth
if ! docker ps --all --format "{{.Names}}" | grep -Fxq "$CONTAINER"; then
	echo "Creating new container..."
	docker create \
		--interactive --tty \
		--volume "$MOUNT_LOCATION:/zphisher/auth/" \
		--network host \
		--name "${CONTAINER}" \
		"${IMAGE}"
fi

docker start --attach --interactive "${CONTAINER}"

# docker run --rm -ti --network="host" -v ${MOUNT_LOCATION}:/zphisher/auth/ --name "$CONTAINER" "$IMAGE"
