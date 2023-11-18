#! /bin/bash

set -xe

cd /opt/sausage-store/bin/
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} \
-o sausage-store-${VERSION}.jar \
${NEXUS_BACKEND_REPO_URL}sausage-store/com/yandex/practicum/devops/sausage-store/${VERSION}/sausage-store-${VERSION}.jar

services=$(systemctl list-units --full --no-legend 'sausage-backend@*' | awk '{print $1}')
previous_version=$(systemctl list-units --full --no-legend 'sausage-backend@*' | awk -F'[@.]' '{print $2"."$3"."$4}')
if [ -n "$previous_version" ]; then
  previous_binary=sausage-store-${previous_version}.jar
fi

if [ -n "$services" ]; then
  for service in $services; do
      echo "Disable service: $service"
      sudo systemctl stop "$service"
      sudo systemctl disable "$service"
      sudo systemctl reset-failed "$service" #Т.к предыдущие версии джобов остаются, но с ошибкой удаляем их
  done
fi

if [ -n "$previous_binary" ]; then
  rm $previous_binary
fi

sudo systemctl start sausage-backend@${VERSION}.service
sudo systemctl enable sausage-backend@${VERSION}.service