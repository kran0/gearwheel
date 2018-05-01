#!/usr/bin/env gearwheel

#!/bin/sh # sh actually runs this script. Gearwheel is just a wrapper.
#TASK_WORKDIR='/home/user/project1'                       # default TASK_WORKDIR=$PWD.
                                                         # Start service AFTER this setting.

wheelctl start dind > "$TASK_SVC_TMP"; . "$TASK_SVC_TMP" # Start DIND. Ugly? Sorry about that.

set -ex # Enable paranoid mode. The build script starts here.
# -----------------------------------------------------------------------------

# Example random project: using dockerised git ad docker-compose. Building in dind
git clone https://github.com/twogg-git/docker-compose-java.git
pushd docker-compose-java
[ "$(/usr/sbin/getenforce)" = "Enforcing" ] && chcon -Rt svirt_sandbox_file_t ./ # selinux right context for all project

docker-compose build
docker-compose up -d
docker-compose down

popd #docker-compose-java

# Example random project: using dockerised git ad docker. Building in dind
git clone https://github.com/twogg-git/docker-nginx.git
pushd docker-nginx

popd #docker-nginx

# -----------------------------------------------------------------------------
set +ex # The build script end.

# If your services are still running, then each of it will be stopped.
# In some cases services try to save their state.
#	 E.g.: dind will save docker images and dolcer volumes to the $DIND_TARGET_DIR.
