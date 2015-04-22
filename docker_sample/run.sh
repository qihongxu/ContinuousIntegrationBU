#!/bin/bash

ImageName=rootnotfound/myapp
hostIP=8080

sudo docker -d &
sudo docker build -t=$\"ImageName\" docker-sample
sudo docker run -p=\"$hostIP:80\" ImageName