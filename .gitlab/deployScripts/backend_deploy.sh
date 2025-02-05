#! /bin/bash

set -xe

service_file=$(cat sausage-backend@.service)

# Определение переменных для замены
variables=("PSQL_PASSWORD" "MONGO_PASSWORD")

# Замена значений вида {{VAR}} на значения переменных окружения
for var in "${variables[@]}"; do
    service_file=$(echo "$service_file" | sed -e "s/{{$var}}/${!var}/g")
done

# Сохранение измененного файла
echo "$service_file" > sausage-backend@.service.updated

# Заменяем конфиг сервиса
sudo mv -f sausage-backend@.service.updated /etc/systemd/system/sausage-backend@.service

#Загружаем артефакт
cd /opt/sausage-store/bin/
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} \
-o sausage-store-${VERSION}.jar \
${NEXUS_BACKEND_REPO_URL}sausage-store/com/yandex/practicum/devops/sausage-store/${VERSION}/sausage-store-${VERSION}.jar

#Получаем список запущенных сервисов нашего бэкенда
services=$(systemctl list-units --full --no-legend 'sausage-backend@*' | awk '{print $1}')
previous_version=$(systemctl list-units --full --no-legend 'sausage-backend@*' | awk -F'[@.]' '{print $2"."$3"."$4}')
if [ -n "$previous_version" ]; then
  previous_binary=sausage-store-${previous_version}.jar
fi

#Отключаем предыдущие версии сервисов нашего бэкенда
if [ -n "$services" ]; then
  for service in $services; do
      echo "Disable service: $service"
      sudo systemctl stop "$service"
      sudo systemctl disable "$service"
      sudo systemctl reset-failed "$service" #Т.к предыдущие версии джобов остаются, но с ошибкой удаляем их
  done
fi

#Удаляем предыдущие версии приложения, если таковые имеются
if [ -n "$previous_binary" ]; then
  rm $previous_binary
fi

#Запускаем новую версию бэкенда
sudo systemctl daemon-reload
sudo systemctl start sausage-backend@${VERSION}.service
sudo systemctl enable sausage-backend@${VERSION}.service