# Gearwheel or Gearwheels

Gearwheel is a toolset used mostly for building docker images.

## What Gearwheel is?

Gearwheels is currnetly a wrapper written in shell (sh).

## What Gearwheels does? And why?

* Transparent substitution of commands like 'docker' 'docker-compose' 'mvn' and such with their dockerised versions;
  * This is usefull when incompatible tools runs on the same host;
* Add 'services' like dind and use them seamless with dockerized tools;
  * Build isolation;
  * Build in modern dind while host's dockerd is 1.12+;
* Export docker images and docker volumes standart way.

With gearwheels you can use build machine with with only software config:
- Coreutils;
- Docker v1.12+;
- Gearwheel.
No other tools needed, you can even use coreutils from busybox:latest.

## How to use Gearwheels?

### Quick start

You can check the work by just run example build. E.g.: Just run $ ./Jenkins_example-project

No, you dont need Jenkins, thats just the name of start script.
Jenkins_example-project just 'emulates' build server's work:
- sets some environment;
- changes the working directory;
- starts the build: $ script build-example-project.sh.

The build script build-example-project.sh contains several example build tasks.
You will get example docker artifacts in workdir/docker-target.

### Full instructions

- First you need a project with complete build script like: unzip, change directory, perform build steps;
- Create or select profiles usefull for your build job and set it in GEARWHEEL_WHEELS variable.
  - Profile may contain one or more space separated names from local/etc/gearwheel.d/*. If there are duplicated utils, first profile will be used first;
  - If you wahnt to create nwe profile, use local/etc/gearwheel.d/multigear.sh. It will create new profile from the DEFAULT one;
- Name your build job and set the name in GEARWHEEL_TASKID variable;
- Using build-example-project.sh add your build script in build-*.sh. Your build jobs should be between two horizontal lines.
  - Actually, you can build anywhere, but for first time better place your jib between the lines;
- Run build-*.sh with at least GEARWHEEL_WHEELS and GEARWHEEL_TASKID variables set.
  - you can use Jenkins_example-project to prepare a starter script for your project. It sets variables and runs build-*.sh.

* You can use it on desktop:
  - use something like Jenkins_example-project script as starter script;
* You can use it on a build server:
  - use Jenkins_example-project to find out what variables to set while executing build-*.sh build task from build server's pipeline;
* You can use it other way.

## Todo

* Add and test more tools;
* Optimize code to run in Apline linux and jenkins:alpine;
* Code clean:
  * VERBOSE_LEVELs;
  * More useful diagnostic messages;
  * Maybe slow parts rewrite;
* Test in various sutuations.
