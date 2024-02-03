#! /bin/bash

set -xe

attempt=0
BLUE_SERVICE_NAME="${SERVICE_NAME}-blue"
GREEN_SERVICE_NAME="${SERVICE_NAME}-green"
      
docker login -u ${CI_REGISTRY_USER} -p${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
      
if docker ps --format '{{.Names}}' | grep -q "${BLUE_SERVICE_NAME}"; then
  echo "${BLUE_SERVICE_NAME} запущен на  сервере."
  echo "Запускаем ${GREEN_SERVICE_NAME}" 
  docker-compose -f ${COMPOSE_PATH} pull ${GREEN_SERVICE_NAME}
  docker-compose -f ${COMPOSE_PATH} up -d ${GREEN_SERVICE_NAME}
        
  while [ "$(docker inspect --format='{{.State.Health.Status}}' "${GREEN_SERVICE_NAME}")" != "healthy" ]; do
    echo "Ожидание завершения запуска контейнера (попытка $((attempt+1)))..."
    sleep 5
    attempt=$((attempt+1))
      
    if [ "$attempt" -eq "$MAX_ATTEMPTS" ]; then
      echo "Достигнуто максимальное число попыток ожидания завершения старта контейнера, отмена операции деплоя."
      docker-compose -f ${COMPOSE_PATH} stop ${GREEN_SERVICE_NAME}
      exit 1
    fi
  done
  
  echo "Отключаем blue контейнер."
  docker-compose -f ${COMPOSE_PATH} stop ${BLUE_SERVICE_NAME}
elif docker ps --format '{{.Names}}' | grep -q "${GREEN_SERVICE_NAME}"; then
  echo "${GREEN_SERVICE_NAME} запущен на  сервере."
  echo "Запускаем ${BLUE_SERVICE_NAME}"
  docker-compose -f ${COMPOSE_PATH} pull ${BLUE_SERVICE_NAME}
  docker-compose -f ${COMPOSE_PATH} up -d ${BLUE_SERVICE_NAME}
      
  while [ "$(docker inspect --format='{{.State.Health.Status}}' "${BLUE_SERVICE_NAME}")" != "healthy" ]; do
    echo "Ожидание завершения запуска контейнера (попытка $((attempt+1)))..."
    sleep 5
    attempt=$((attempt+1))
      
    if [ "$attempt" -eq "$MAX_ATTEMPTS" ]; then
      echo "Достигнуто максимальное число попыток ожидания завершения старта контейнера, отмена операции деплоя."
      docker-compose -f ${COMPOSE_PATH} stop ${BLUE_SERVICE_NAME}
      exit 1
    fi
  done
  
  echo "Отключаем green контейнер."      
  docker-compose -f ${COMPOSE_PATH} stop ${GREEN_SERVICE_NAME}
fi