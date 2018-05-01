# Gearwheel or Gearwheels

Gearwheel is a toolset used mostly for building docker images.

## What Gearwheel is?

Gearwheels is currnetly a wrapper written in shell (sh).

## What Gearwheels does? And why?

* Transparent substitution of commands like 'docker' 'docker-compose' 'mvn' and such (potentially any command or program) with their dockerised versions;
  * Usefull if the tool is ugly and dirty and you just wahnt not to install in on the host;
  * Usefull when incompatible tools rejects to run on the same host;
  * Usefull to get new and even edge versions of tools on industrial distributives.
* Run in docker 'services' like dind and use them seamless with dockerized tools;
  * Same as above including build in modern dind while host's dockerd is 1.12+;
  * + Per build service isolation.
* Export docker images and docker volumes standart way.
  * After build finishes, the service will automatic export its artifacts.

You can use CI/CD machine with with only:
- Coreutils;
- Docker v1.12+;
- Gearwheel.
No other tools needed, you can even use coreutils from busybox:latest.

## How to use Gearwheels?

### Quick start

You can check it works by just run example build. E.g.: Just run $ ./Jenkins_example-project

No, you dont need Jenkins, thats just the name of start script.
Jenkins_example-project just 'emulates' build server's work:
- sets some environment;
- changes working directory;
- starts the build: $ ./build-example-project.sh.

Build script ./build-example-project.sh contains several example build tasks.
After test build finishes, you will get example docker artifacts in ./workdir/docker-target/.

### Slow start

* EXAMPLE #1
Let's say you are to build docker image from Dockerfile.
You just can replace conthent between two horisontal lines in ./build-example-project.sh with:
```bash
# -----------------------------------------------------------------------------

pushd /directory/with/Dockerfile
docker build -t targettag:latest .
popd

# -----------------------------------------------------------------------------
```

* EXAMPLE #2
Let's say you are to build docker project with docker-compose.yaml.
You just can replace conthent between two horisontal lines in ./build-example-project.sh with:
```bash
# -----------------------------------------------------------------------------

pushd /directory/with/docker-compose.yaml
docker-compose build
docker-compose up -d
docker-compose down
popd

# -----------------------------------------------------------------------------
```

### Full instructions

- First you need a project with complete build script like: unzip, change directory, perform build steps;
- Create or select 'wheels' (profiles) usefull for your build job and set it in GEARWHEEL_WHEELS variable;
  - GEARWHEEL_WHEELS variable may contain one or more space separated profile names from local/etc/gearwheel.d/*. If there are duplicated tools inside them, first wheel (profile) will be used first;
  - If you wahnt to create new wheel (profile), use local/etc/gearwheel.d/multigear.sh. It will create new wheel from the DEFAULT one.
- Name your build job and set the name in GEARWHEEL_TASKID variable;
  - You dont have to do it, GEARWHEEL_TASKID will be autosed to some ugly string if not set.
- Using build-example-project.sh add your build script in build-*.sh. Your build jobs should be between two horizontal lines;
  - Actually, you can build anywhere, but for first time better place your jib between the lines.
- Run build-*.sh with GEARWHEEL_WHEELS and GEARWHEEL_TASKID variables set;
  - If GEARWHEEL_WHEELS is not set, then DEFAULT whell is used;
  - If GEARWHEEL_TASKID is not set, them GEARWHEEL_TASKID is generated;
  - You can use Jenkins_example-project to prepare a starter script for your project. It sets variables and runs build-*.sh;
  - If you running script as part of CI/CD pipeline, make sure env variables are set.

* You can use it on desktop:
  - use something like Jenkins_example-project script as starter script;
* You can use it on a build server:
  - use Jenkins_example-project to find out what variables to set for executing build-*.sh from build server's pipeline;
* You can use it other way.

## Todo

* Add and test more tools;
* Optimize code to run in Apline linux and jenkins:alpine;
* Code clean:
  * VERBOSE_LEVELs;
  * More useful diagnostic messages;
  * Maybe slow parts rewrite;
* Test in various sutuations.
