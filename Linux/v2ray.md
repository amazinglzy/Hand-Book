curl -O https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh
bash install-release.sh

$IP=xx.xx.xx.xx

{
  "inbounds": [{
    "port": 13103,
    "protocol": "vmess",
    "settings": {
      "clients": [
        {
          "id": "c22cd567-e577-4a2d-bebf-2e15fca9e0ff",
          "level": 1,
          "alterId": 64
        }
      ]
    }
  }],
  "outbounds": [{
    "protocol": "freedom",
    "settings": {}
  },{
    "protocol": "blackhole",
    "settings": {},
    "tag": "blocked"
  }],
  "routing": {
    "rules": [
      {
        "type": "field",
        "ip": ["geoip:private"],
        "outboundTag": "blocked"
      }
    ]
  }
}

{
  "log": {
    "error": "",
    "loglevel": "info",
    "access": ""
  },
  "inbounds": [
    {
      "listen": "127.0.0.1",
      "protocol": "socks",
      "settings": {
        "ip": "",
        "userLevel": 0,
        "timeout": 360,
        "udp": false,
        "auth": "noauth"
      },
      "port": "1080"
    },
    {
      "listen": "127.0.0.1",
      "protocol": "http",
      "settings": {
        "timeout": 360
      },
      "port": "1087"
    }
  ],
  "outbounds": [
    {
      "mux": {
        "enabled": false,
        "concurrency": 8
      },
      "protocol": "vmess",
      "streamSettings": {
        "tcpSettings": {
          "header": {
            "type": "none"
          }
        },
        "tlsSettings": {
          "allowInsecure": true
        },
        "security": "none",
        "network": "tcp"
      },
      "tag": "agentout",
      "settings": {
        "vnext": [
          {
            "address": "$IP",
            "users": [
              {
                "id": "c22cd567-e577-4a2d-bebf-2e15fca9e0ff",
                "alterId": 64,
                "level": 1,
                "security": "auto"
              }
            ],
            "port": 13103
          }
        ]
      }
    },
    {
      "tag": "direct",
      "protocol": "freedom",
      "settings": {
        "domainStrategy": "AsIs",
        "redirect": "",
        "userLevel": 0
      }
    },
    {
      "tag": "blockout",
      "protocol": "blackhole",
      "settings": {
        "response": {
          "type": "none"
        }
      }
    }
  ],
  "dns": {
    "servers": [
      ""
    ]
  },
  "routing": {
    "strategy": "rules",
    "settings": {
      "domainStrategy": "IPIfNonMatch",
      "rules": [
        {
          "outboundTag": "direct",
          "type": "field",
          "ip": [
            "geoip:cn",
            "geoip:private"
          ],
          "domain": [
            "geosite:cn",
            "geosite:speedtest"
          ]
        }
      ]
    }
  },
  "transport": {}
}
