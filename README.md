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

_TODO: add instructions__

* You can use it on desktop;
* You can use it on a build server;
* You can use it other way.
