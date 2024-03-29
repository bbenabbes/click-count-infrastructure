FROM centos:7
# Install systemd -- See https://hub.docker.com/_/centos/
RUN yum -y -q swap -- remove fakesystemd -- install systemd systemd-libs
RUN yum -yqq update; yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*; \
rm -f /etc/systemd/system/*.wants/*; \
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*; \
rm -f /lib/systemd/system/anaconda.target.wants/*;
# Install Ansible
RUN yum -y -q install epel-release
RUN yum -y -q install git ansible sudo
RUN yum clean all
# Disable requiretty
RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers
COPY ./ /etc/ansible
RUN ansible-galaxy install -r /etc/ansible/requirements.yml
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
