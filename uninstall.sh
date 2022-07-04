# /bin/bash
if [ "$(id -u)" != "0" ]; then
    echo 'Permission denied. Are you root?'
    exit 1
fi
systemctl stop cloudflare-ddns
systemctl disable cloudflare-ddns
rm /etc/systemd/system/cloudflare-ddns.service /etc/cloudflare-ddns.conf  /usr/local/bin/cloudflare-ddns
echo "Uninstallation successfully succeeded in success."