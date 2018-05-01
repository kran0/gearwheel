#!/usr/bin/env gearwheel

#!/bin/sh # sh actually runs this script. Gearwheel is just a wrapper.
#TASK_WORKDIR='/home/user/project1'     # default TASK_WORKDIR=$PWD.
                                        # Start service AFTER this setting.

wheelctl start dind > "$TASK_SVC_TMP"; . "$TASK_SVC_TMP" # Start DIND. Ugly? Sorry about that.

set -ex # Enable paranoid mode. The build script starts here.
# -----------------------------------------------------------------------------

# First example: using dockerised 'cat' pipe to dockerised 'gzip'. Running in dind
# Dockerd (thanks to dind: Docker in docker) is running inside a container on the host.
# cat runs in one container, and gzip in another! Both are inside dind. MADNESS!
cat /etc/hostname | gzip > example.gz

# Example #2 random project with docker-compose and java. Building in dind
git clone https://github.com/twogg-git/docker-compose-java.git # dockerised git
pushd docker-compose-java
[ "$(/usr/sbin/getenforce)" = "Enforcing" ] && chcon -Rt svirt_sandbox_file_t ./ # selinux right context for all project
docker-compose build # dockerised compose
docker-compose up -d
docker-compose down
popd #docker-compose-java

# Example #3 random project with docker. Building in dind
git clone https://github.com/twogg-git/docker-nginx.git
pushd docker-nginx
docker build -t nginx:site . # dockerised docker client
popd #docker-nginx

# -----------------------------------------------------------------------------
set +ex # The build script end.

# If your services are still running, then each of it will be stopped.
# In some cases services try to save their state.
#	 E.g.: dind will save docker images and docker volumes to the $DIND_TARGET_DIR.
