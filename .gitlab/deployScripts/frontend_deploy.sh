#! /bin/bash

set -xe

cd /opt/sausage-store/static/
echo "curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store-${VERSION}.tar.gz ${NEXUS_FRONTEND_REPO_URL}${VERSION}/sausage-store-${VERSION}.tar.gz"
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} \
-o sausage-store-${VERSION}.tar.gz \
${NEXUS_FRONTEND_REPO_URL}${VERSION}/sausage-store-${VERSION}.tar.gz

rm -rf dist/frontend

tar -xzvf sausage-store-${VERSION}.tar.gz -C dist/

rm sausage-store-${VERSION}.tar.gz

sudo systemctl restart nginx