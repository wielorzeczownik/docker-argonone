# Stage 1:
# 🐳 Start from the Ubuntu image.
FROM ubuntu:20.04 as download-stage

# 📦 Installation of curl tool.
RUN apt-get update && apt-get install -y curl

# ⬇️ Download the Argon ONE driver script.
RUN curl -L https://download.argon40.com/argon1.sh -o /argon1.sh

# Stage 2:
# 🐳 Start from the Ubuntu image.
FROM ubuntu:20.04 as build-stage

# 📝 Add information about the maintainer and the image.
LABEL maintainer="wielorzeczownik <wielorzeczownik@furryunicorn.com>" \
description="🐳 Docker version of the driver for 🐚Argon ONE"

# 📦 Update and install necessary packages.
RUN apt-get update && apt-get install -y sudo systemd

# 🚫 Remove any timer files to prevent errors during runtime.
RUN find /etc/systemd -name '*.timer' | xargs rm -v || true && \
systemctl set-default multi-user.target

# 📋 Copy the downloaded script from the download-stage
COPY --from=download-stage /argon1.sh /argon1.sh

# ⚙️ Make the downloaded script executable
RUN chmod +x /argon1.sh

# 🐚 Install drivers for Argon ONE by running the script
RUN ./argon1.sh

# 🚀 Enable the Argon ONE service.
RUN systemctl enable argononed

# 🧹 Clean up unnecessary files and packages
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /argon1.sh

# 🚪 Use systemd as the entrypoint for the container.
CMD ["/lib/systemd/systemd"]
