#!/bin/bash

set -ex

command -v python3 || dnf -y install python3

TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
IID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
mkdir -p /var/www/html
cat > /var/www/html/index.html <<EOF
<!doctype html>
<html><body style="font-family:system-ui;">
<h1>It works! ✨</h1>
<p>Served by <strong>${IID}</strong></p>
</body></html>
EOF

nohup python3 -m http.server 80 --directory /var/www/html >/var/log/web.log 2>&1 &