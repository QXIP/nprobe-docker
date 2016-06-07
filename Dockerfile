FROM phusion/baseimage:0.9.18
MAINTAINER L. Mangani <mangani@ntop.org>

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Update & Install from NTOP Package
RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get -y -q install curl
RUN curl -s --remote-name http://packages.ntop.org/apt/14.04/all/apt-ntop.deb
RUN sudo dpkg -i apt-ntop.deb
RUN rm -rf apt-ntop.deb

# Install nProbe
RUN apt-get update
RUN apt-get -y -q install nprobe

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Run & Obtain ID
RUN nprobe -v
