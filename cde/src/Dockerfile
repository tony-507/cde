FROM rockylinux:9.0
RUN useradd -rm -d /home/rocky -s /bin/bash -g root rocky && mkdir -p /opt/tony57/tmp && mkdir -p /mnt
COPY scripts /opt/tony57/tmp/.
COPY rpm /opt/tony57/rpm/.
RUN chmod +x /opt/tony57/tmp/preBuild.sh && /opt/tony57/tmp/preBuild.sh && /opt/tony57/tmp/install_packages.sh && /opt/tony57/tmp/dood.sh
RUN rm -rf /opt/tony57/tmp
