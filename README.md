# gearwheel

Gearwheel is a toolset for building docker images

## What Gearwheel is?

Gearwheels is currnetly a wrapper written in shell (sh).

## What Gearwheels does? And why?

* Transparent substitution of commands like 'docker' 'docker-compose' 'mvn' and such with their dockerised versions;
  * This is usefull when incompatible tools runs on the same host;
* Add 'services' like dind and use them seamless with dockerized tools;
  * Build isolation;
  * Build in modern dind while host's dockerd is 1.12+;
* Export docker images and docker volumes standart way.

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

_TODO: add instructions_

* You can use it on desktop;
* You can use it on a build server;
* You can use it other way.

## Todo

* Add and test more tools;
* Optimize code to run in Apline linux and jenkins:alpine;
* Code clean:
  * VERBOSE_LEVELs;
  * More useful diagnostic messages;
  * Maybe slow parts rewrite;
* Test in various sutuations.
