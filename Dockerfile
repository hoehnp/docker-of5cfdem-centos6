FROM centos:centos6.9
ADD ./install-packages.sh /tmp/install-packages.sh
RUN ["chmod", "+x",  "/tmp/install-packages.sh"]
RUN ["bash",  "-c", "/tmp/install-packages.sh"]
RUN ["useradd", "--create-home", "-s", "/bin/bash", "vagrant"]
WORKDIR /home/vagrant
USER vagrant
ADD ./cfdem.sh /tmp/cfdem.sh
RUN ["bash",  "-c", "/tmp/cfdem.sh"]


