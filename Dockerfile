FROM ubuntu:trusty

MAINTAINER Benjamin Ward "ward.programm3r@gmail.com"

# Install PPA support
RUN apt-get install -yq software-properties-common

# Install WPILib/FRC Toolchain
RUN apt-add-repository ppa:wpilib/toolchain && apt-get update && apt-get install -yq frc-toolchain

# Install git 
RUN apt-get install -yq git

WORKDIR /build

ADD ci.sh /build/ci.sh

CMD ["/bin/sh", "ci.sh"]
