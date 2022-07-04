# Cloudflare DDNS for linux by shell

A shell script and service to use cloudflare as dynamic DNS.

## Setup

Add a relevant DNS record at cloudflare, any record you like such as `::1`(AAAA) is okidoki, or you will experience an error.

You need to acquire an **API Token** (NOT API Key) at <https://dash.cloudflare.com/profile/api-tokens> ;

Use the template "Edit zone DNS" and follow the instruction;

**Remember that Token.**

Install the DDNS script:

```sh
git clone --depth 1 https://github.com/saeziae/cloudflare-ddns.git
sudo bash install.sh
```

Configuration file is generated at `/etc/cloudflare-ddns.conf`, with descriptions

```sh
auth_key="CyaEgHaNhelVMarEnOl"    #Your API TOKEN (NOT API Key) at https://dash.cloudflare.com/profile/api-tokens
zone_name="example.com"           #Your domain
record_name="example.example.com" #Your record
record_type="AAAA"                # A for ipv4 and AAAA for ipv6
#REMIND: firstly you have to add the record manually on dashboard, 127.0.0.1(A) or ::1(AAAA) is OK
ip_index="internet"     #internet or local
internet_ip_api="ip.sb" #your api to fetch IP address via internet
eth_card="auto"         #your network adaptor to get IP address locally, use "auto" to use default
```

Edit it following the instuction

```sh
systemctl enable --now cloudflare-ddns
```

## Uninstallation

```sh
sudo bash uninstall.sh
```

Configuration file will be removed together.

## Common problems

1.  ```json
    {
      "success": false,
      "errors": [
        {
          "code": 10000,
          "message": "PUT method not allowed for the api_token authentication scheme"
        }
      ]
    }
    ```
    Add a relevant DNS record firstly at cloudflare dashboard, any record you like is okay. For example, if you want to use DDNS for `aaaa.example.com` with ipv6, add an AAAA record `::1` for `aaaa` for `example.com`.
