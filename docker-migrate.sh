#!/bin/bash
# Here is a script to migrate docker images from one instance of docker to another

if [ "$1" = "export" ]; then
    if [ ! -d $2 ]; then
	mkdir $2
    fi
    if [ ! -d $2/images ]; then
	mkdir $2/images
    fi
    if [ ! -d $2/containers ]; then
	mkdir $2/containers
    fi
    if [ ! -d $2/volumes ]; then
	mkdir $2/volumes
    fi
    for i in $( sudo docker images -q ); do
	echo $i
	sudo docker save $i > $2/images/$i.tar
    done
    sudo tar -zcvf $2/volumes/volumeData.tar.gz /var/lib/docker/volumes
    if [ -d /var/lib/docker/vfs ]; then
	sudo tar -zcvf $2/volumes/vfsData.tar.gz /var/lib/docker/vfs
    fi
    
elif [ "$1" = "import" ]; then
    if [ ! -d "$2" ]; then
	echo "Specified directory $2 does not exist"
	exit
    fi
    for i in $( ls $2/images ); do
	echo $i
	sudo docker load < $2/images/$i
    done
    gunzip $2/volumes/volumeData.tar.gz
    sudo mv $2/volumes/volumeData.tar /var/lib/docker
    sudo tar xvf /var/lib/docker/volumeData.tar
fi
