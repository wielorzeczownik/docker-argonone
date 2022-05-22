FROM navikey/raspbian-buster:latest

# Updating and installing the necessary packages
RUN apt-get update && apt-get upgrade && \
    apt-get install curl systemd -y

# Systemd settings
RUN find /etc/systemd -name '*.timer' | xargs rm -v && \
	systemctl set-default multi-user.target

# Installation of drivers for ArgonOne.
RUN curl https://download.argon40.com/argon1.sh | bash
RUN systemctl enable argononed

# Cleaning image.
RUN apt-get purge nano curl openssl -y && \
    apt-get autoremove -y && \
    apt-get clean && \
    apt-get autoclean && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f  /etc/ssh/ssh_host_* && \
    rm -rf /usr/share/man/?? && \
    rm -rf /usr/share/man/??_* && \
	rm -rf /var/run/apt/sources.list*

ENTRYPOINT ["/lib/systemd/systemd"]