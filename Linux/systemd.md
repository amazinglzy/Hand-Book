# Systemd

```sh
[Unit]
Description=Doi

[Service]
ExecStart=/usr/bin/java -jar /home/owly/gs-rest-service-0.1.0.jar
ExecStop=

[Install]
WantedBy=multi-user.target
```