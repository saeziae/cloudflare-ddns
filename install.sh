# /bin/bash
if [ "$(id -u)" != "0" ]; then
    echo 'Permission denied. Are you root?'
    exit 1
fi
if [ -f /etc/systemd/system/cloudflare-ddns.service ]; then
    echo 'Service already exists. Ignoring.'
else
    echo >/etc/systemd/system/cloudflare-ddns.service <<EOF
[Unit]
Description=Cloudflare DDNS
After=network.target
[Service]
Type=exec
Restart=on-abort
ExecStart=/bin/sh -c 'ip monitor | while read; do cloudflare-ddns; done'
[Install]
WantedBy=multi-user.target
EOF
    echo 'Installed service.'
fi
if [ -f /etc/cloudflare-ddns.conf ]; then
    echo 'Configuration file already exists. Ignoring.'
else
    echo >/etc/cloudflare-ddns.conf <<EOF
auth_key="CyaEgHaNhelVMarEnOl"    #Your API TOKEN (NOT API Key) at https://dash.cloudflare.com/profile/api-tokens
zone_name="example.com"           #Your domain
record_name="example.example.com" #Your record
record_type="AAAA"                # A for ipv4 and AAAA for ipv6
#REMIND: firstly you have to add the record manually on dashboard, 127.0.0.1(A) or ::1(AAAA) is OK
ip_index="internet"     #internet or local
internet_ip_api="ip.sb" #your api to fetch IP address via internet
eth_card="auto"         #your network adaptor to get IP address locally, use "auto" to use default
EOF
    echo 'Installed configuration file.'
fi
cp cloudflare-ddns /usr/local/bin/cloudflare-ddns
chmod +x /usr/local/bin/cloudflare-ddns
echo 'Installed main programme.'
echo -e 'Installation successfully succeeded in success.\nPlease edit /etc/cloudflare-ddns.conf firstly\nThen run \`systemctl enable --now cloudflare-ddns\` to enable'
