FROM centos:latest
#FROM centos/systemd:latest
#FROM centos:8.3.2011

ARG USER=jarosm3
ARG PASSWORD=lqrtpb_2
ARG DISPLAY=1

ARG TZ=Europe/Amsterdam

#RUN yum upgrade -y

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]


RUN yum install -y --allowerasing epel-release

RUN yum groupinstall -y --allowerasing "Server with GUI"
RUN systemctl set-default graphical
##RUN yum group list

RUN yum install -y --allowerasing tigervnc-server
RUN yum install -y --allowerasing xorg-x11-fonts-Type1

#RUN dnf install --nodocs -y epel-release
#RUN dnf install --nodocs -y glibc-langpack-en
#RUN dnf tigervnc-server
#
## Create user and set password.
## Add to wheel for sudo use.
#RUN useradd -m -s /bin/bash ${USER}
#RUN echo "${USER}:${PASSWORD}" | chpasswd
#RUN usermod -aG wheel ${USER}
#
## Add user to VNC list
#RUN echo ":${DISPLAY}=${USER}" >> /etc/tigervnc/vncserver.users
#
#RUN systemctl enable vncserver@:${DISPLAY}.service
#RUN systemctl start vncserver@:${DISPLAY}.service
#
## Run commands as non-root user to prevent having to set a lot of permissions and ownership.
#USER ${USER}
#
## Configure password for TigerVNC and start openbox on TigerVNC startup.
#RUN mkdir ~/.vnc && echo "${PASSWORD}" | /usr/bin/vncpasswd -f > ~/.vnc/passwd && chmod 600 ~/.vnc/passwd
###RUN echo "openbox-session" > ~/.vnc/xstartup && chmod +x ~/.vnc/xstartup
###RUN echo "gnome-session" > ~/.vnc/xstartup && chmod +x ~/.vnc/xstartup
#
#
#
## VNC, RDP, noVNC
#EXPOSE 5901