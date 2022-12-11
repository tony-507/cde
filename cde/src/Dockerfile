FROM rockylinux:9.0
RUN mkdir -p /opt/tony57/tmp /opt/tony57/tmp /mnt
COPY scripts /opt/tony57/tmp/.
COPY rpm /opt/tony57/rpm/.
RUN chmod +x /opt/tony57/tmp/preBuild.sh && /opt/tony57/tmp/preBuild.sh && /opt/tony57/tmp/install_packages.sh && /opt/tony57/tmp/dood.sh
RUN rm -rf /opt/tony57/tmp
