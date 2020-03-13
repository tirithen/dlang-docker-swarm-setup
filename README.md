# dlang-docker-swarm-setup - Experiments with running D projects in docker swarm environments

The current state of this setup is that the `hellod` and `hellodalpine` services crashes (or gets restarted) as soon as they gets an HTTP call.

For reference the hellojs (a simple Node.js service) and hellod-working-why (image tam4s/hello-vibe-x86_64) works as expected without any problems.

The goal of this repo is to figure out why and expecially how to get dlang web servers to work with alpine images to keep the size small.

Feel free to provide pull-requests if you can improve the setup.

## Running the experiment

To run this experiment you need to have `docker` and `docker-compose` packages installed.

    # Enabling docker swarm mode (if not already setup)
    docker swarm init

    # Building the docker images
    docker-compose build

    # Running the swarm stack
    docker stack deploy -c docker-compose.yml dlangtest

    # Testing the services (ensure that you have docker.localhost setup see below)
    curl -i docker.localhost/api/hellojs
    curl -i docker.localhost/api/hellod
    curl -i docker.localhost/api/hellodalpine
    curl -i docker.localhost/api/hellod-working-why

## Setup docker.localhost

Check the IP address assigned to the docker_gwbridge interface:

    $ ip addr | grep "global docker0"  

Add that entry to your /etc/hosts file (in my case 172.17.0.1):

    $ sudo echo "172.17.0.1      docker.localhost" >> /etc/hosts

## Watch the running services

Useful while debugging:

    $ watch docker service ls

## Cleanup/remove the docker stack

In between the various tries the stack needs to be cleared out/removed with:

    $ docker stack rm dlangtest
