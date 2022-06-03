#!/bin/bash

rm -f web config.json
wget -N https://raw.githubusercontent.com/bhqz/Alwaysdata-vmess-vless-trojan-/main/web
chmod +x ./web

if [[ -z $id ]]; then
    id="333c130d-e3b2-4341-a221-dccc36cfab72"
fi

cat <<EOF > ~/config.json
{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$id"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

./web -config=config.json
