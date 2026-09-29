#!/bin/bash
# setup-vm.sh — reinstall everything the oci-arm-host-capacity poller needs
# after this VM is restarted/replaced (only $HOME persists; /usr and /var are wiped).
# Run as root:  sudo ./setup-vm.sh
set -e

# 1. APT sources: the image's default mirror list may be broken/slow after reset.
if [ -f /etc/apt/sources.list.d/ubuntu.sources ]; then
    mv /etc/apt/sources.list.d/ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources.disabled 2>/dev/null || true
fi
printf 'Types: deb\nURIs: http://archive.ubuntu.com/ubuntu\nSuites: noble noble-updates noble-backports noble-security\nComponents: main restricted universe multiverse\nSigned-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg\n' \
    > /etc/apt/sources.list.d/ubuntu.sources

# 2. Packages
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y -qq php-cli php-curl php-mbstring unzip cron

# 3. Composer
if ! command -v composer >/dev/null 2>&1; then
    curl -sSL -o /usr/local/bin/composer https://getcomposer.org/download/latest-stable/composer.phar
    chmod +x /usr/local/bin/composer
fi

# 4. Project dependencies (no-op if vendor/ already present)
cd /home/hatch/workspace/oci-arm-host-capacity
if [ ! -d vendor ]; then
    COMPOSER_ALLOW_PLUGINS=1 composer install --no-dev --no-interaction
fi

# 5. Cron daemon (no systemd here)
pgrep -x cron >/dev/null || /usr/sbin/cron

# 6. Every-minute poller (run.sh exports the egress proxy; see HttpClient.php patch)
touch oci.log
(crontab -l 2>/dev/null | grep -v "oci-arm-host-capacity/run.sh"; echo "* * * * * /home/hatch/workspace/oci-arm-host-capacity/run.sh") | crontab -

echo "OK: $(php -v | head -1) | cron: $(pgrep -x cron | head -1) | crontab:"
crontab -l
