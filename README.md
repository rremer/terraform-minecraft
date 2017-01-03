terraform-minecraft
===================

An experiment in terraform modules for parallelized deployments of applications to machines.


**TODO**

* determine why aptdcon sometimes exits status 141 without a tty (even with DEBIAN_FRONTEND=noninteractive). There's probably a better way to do parallel installs than piping 'yes' to aptdcon anyways, and perhaps that's the root of the indeterminism.
* find a clever way to avoid persisting the s3 access key id+secret to the statefile, may need to be an upstream patch of this resource in the aws provider (store a hash?)
* outputs for all the things within modules.
