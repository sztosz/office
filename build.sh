#!/bin/sh

docker build -t office/lastest -f Dockerfile.build .
docker cp "`docker ps -l -q`:/build/rel/office/releases/0.0.1/office.tar.gz ./office.tar.gz"
