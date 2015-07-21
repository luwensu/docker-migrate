#!/bin/bash
# Here is a script to migrate docker images from one instance of docker to another

if [ "$1" = "export" ]; then
    mkdir $2 #this is the name of the directory
    for i in $( sudo docker images -aq ); do
	echo $i
	sudo docker save $i > $2/$i.tar
    done
    sudo tar -zcvf volumeData.tar.gz /var/lib/docker/volumes
    
elif [ "$1" = "import" ]; then
    for i in $( ls $2 ); do
	echo $i
	sudo docker load < $2/$i
    done
    rm -r $2
    gunzip volumeData.tar.gz
    sudo mv volumeData.tar /var/lib/docker
    
fi
