#!/bin/sh

if [ -d /etc/apt ]; then
        [ -n "$http_proxy" ] && echo "Acquire::http::proxy \"${http_proxy}\";" > /etc/apt/apt.conf; \
        [ -n "$https_proxy" ] && echo "Acquire::https::proxy \"${https_proxy}\";" >> /etc/apt/apt.conf; \
        [ -f /etc/apt/apt.conf ] && cat /etc/apt/apt.conf
fi

apt update
apt install -y wget unzip

cd /tmp

wget --content-disposition https://api.ngc.nvidia.com/v2/resources/nvidia/ngc-apps/ngc_cli/versions/3.63.0/files/ngccli_linux.zip -O ngccli_linux.zip

unzip ngccli_linux.zip

chmod +x ngc-cli/ngc

mv ngc-cli /usr/local/lib/ngc-cli

echo 'export PATH="$PATH:/usr/local/lib/ngc-cli"' >> ~/.bashrc

source ~/.bashrc

ngc --version

