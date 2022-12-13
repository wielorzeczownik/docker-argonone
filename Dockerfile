# 🐳 Start from the latest Ubuntu image.
FROM ubuntu:latest

# 📝 Add information about the maintainer and the image.
LABEL maintainer="manythingsatonce <manythingsatonce@furryunicorn.com>" \
      description="🐳 Docker version of the driver for 🐚Argon ONE"

# 📦 Update and install necessary packages.
RUN apt-get update && apt-get upgrade -y && \
    apt-get install curl sudo systemd -y 

# 🚫 Remove any timer files to prevent errors during runtime.
RUN find /etc/systemd -name '*.timer' | xargs rm -v || true && \
    systemctl set-default multi-user.target

# 🐚 Install drivers for ArgonOne.
RUN curl -L https://download.argon40.com/argon1.sh | bash

# 🚀 Enable the ArgonOne service.
RUN systemctl enable argononed

# 🧹 Clean the image.
RUN apt-get purge curl language-pack-* manpages nano openssh-server openssl -y && \
    apt-get autoremove -y && \
    apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f  /etc/ssh/ssh_host_* && \
    rm -rf /usr/share/man/?? && \
    rm -rf /usr/share/man/??_* && \
    rm -rf /var/run/apt/sources.list* && \
    rm -rf /usr/share/locale/* && \
    rm -rf /usr/share/doc/* && \
    rm -rf /usr/share/zoneinfo/* && \
    rm -rf /usr/share/info/* && \
    rm -rf /usr/share/lintian/* && \
    rm -rf /usr/share/common-licenses/*

# 🚪 Use systemd as the entrypoint for the container.
ENTRYPOINT ["/lib/systemd/systemd"]