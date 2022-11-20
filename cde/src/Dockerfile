FROM rockylinux:9.0
RUN mkdir -p /opt/tony57/tmp && mkdir -p /mnt
WORKDIR /opt/tony57
COPY install_packages.sh /opt/tony57/tmp/.
RUN chmod +x tmp/install_packages.sh && ./tmp/install_packages.sh && rm -rf /opt/tony57/tmp
