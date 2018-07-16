# CRETE Docker User Guide

## 1. Prerequisites
### 1.1. What is Docker?
Docker provides tools for deploying applications within containers separate from the host OS and other containers. As a result, the setup is quick and streamlined, and the container (along with any changes made within it) is discarded after use. Docker containers are built from a Docker image file.

### 1.2. Install Docker

To utilize the CRETE Docker image, Docker must be installed on your machine. For Ubuntu installation, follow the instructions on the [Docker website](https://docs.docker.com/install/linux/docker-ee/ubuntu/)

## 2. Running CRETE through Docker

### 2.1 Retrieving and building the CRETE Docker image

The Dockerfile used to built the image can be found in the CRETE GitHub repository. Thus, you can build the image by running the following:

```bash
$ git clone https://github.com/justin-bao/crete-dev.git
$ cd crete-dev
$ docker build -t jbao12/crete .
```

### 2.2 Creating a CRETE Docker container

To create a CRETE container from the new image, run the following:

```bash
$ docker run --rm --ti --ulimit='stack=-1:-1' jbao12/crete
```

The _--rm_ option ensures that the container will be removed upon exiting. The _--ulimit_ option sets an unlimited stack size in the container to avoid stack overflow.

## 3. Using QEMU to run CRETE

### 3.1 Installing native QEMU

CRETE requires a native version of QEMU 2.3. This can be downloaded and built by running the following:

```bash
$ wget https://download.qemu.org/qemu-3.0.0-rc0.tar.xz
$ tar xvJf qemu-2.3.0.tar.xz
$ cd qemu-2.3.0
$ ./configure
$ make
```

### 3.2 Downloading the CRETE QEMU image

CRETE requires a QEMU virtual machine to be able to house processes and run effectively. For ease and consistency, we have prepared an image running Ubuntu 14.04 Server with CRETE already built. To download this image, run:

```bash
$ git clone https://projects.cecs.pdx.edu/git/nhaison-creteimg crete-image
$ mv crete-image/img_template/crete.img .
$ rm -r crete-image
```

However, CRETE needs the executable to be tested and a configuration file in order to function. To start QEMU with this image, run:

```bash
$ qemu-system-x86_64 -hda crete.img -m 256 -k en-us
```

The account set up in this OS has the following credentials:

> Username: __crete__
> Password: __crete__

From within the guest OS, you can use:

```bash
$ scp -r <host-user-name>@10.0.2.2:</target/path/in/qemu/OS> .
```

in order to copy your files over.

### 3.3 Creating a configuration file for the executable

CRETE needs a configuration file to determine the location of the executable to be tested and the options with which to test. A template for this configuration file is as follows: 

```xml
<crete>
	<exec>/path/to/executable</exec>
	<args>
		<arg index="1" size="8" value="abc" concolic="true"/>
	</args>
</crete>
```
A brief explaination for each pertinent node is as follows:
```xml
<exec>/path/to/executable/in/QEMU</exec>
```
This is the path to the executable under testing.
```xml
<arg index="1" size="8" value="abc" concolic="true"/>
```
In this configuration, we will test the binary with one concolic argument
with size of 8 bytes and its initial value is "abc".

Copy this configuration file over to the guest OS using the same _scp_ command within QEMU.

### 3.4 Creating a snapshot of the guest OS

Without _kvm_ enabled in QEMU, a snapshot is used by CRETE to start-up quickly. To do this, we must access the QEMU menu. It should be accessible through _ctrl+alt+2_ - however, if this doesn't work, run QEMU with the option:

```bash
-monitor telnet:127.0.0.1:1234,server,nowait
```

and pull up the menu from the host OS by running:

```bash
$ telnet 127.0.0.1 1234
```

Once in the menu for QEMU, run the following to save a snapshot entitled "test":

```bash
$ savevm test
enter
$ q
enter
```

### 3.5 Running CRETE

Navigate to the CRETE directory and run _./command_qemu23.sh_. Once QEMU has been launched, launch CRETE by running:

```bash
$ crete-run -c <name_of_the_configuration_file.xml>
```

Then, run _./command_dispatch.sh_, _./command_start_vm.sh_, and _./command_start_svm.sh_ to initiate CRETE.
