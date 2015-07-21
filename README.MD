# Atomic: Migrate

This script allows the user to easily migrate images, volumes, and
containers from one version of Docker to another.  With the migrate
command, users can quickly save all their data from the current docker
instance, change the docker storage backend, and then import all their
old data to the new system.

## atomic migrate export [directory]

Specify the directory in which to temporarily store the files (can be
an existing directory, or the command will create one)

The export command will export all the current images, volumes, and
containers to the specified directory, in the /images, /volumes,
/containers subdirectories.

## atomic migrate import [directory]

Specify the directory from which to read the files (must be an
existing directory)

The import command will import images, volumes, and containers from
the specified directory into the new docker instance.

Jenny Ramseyer, 2015
