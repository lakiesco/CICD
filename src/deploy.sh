#!/bin/bash

# Параметры удалённого сервера
REMOTE_USER="lakiesco"                # Пользователь на второй ВМ
REMOTE_HOST="192.168.1.11"       # IP-адрес второй ВМ
REMOTE_DIR="/usr/local/bin"       # Директория для развёртывания.

# Путь к файлам, которые нужно передать (артефакты)
ARTIFACTS=("cat/s21_cat" "grep/s21_grep")

# Файл для логирования
LOG_FILE="deploy.log"

# Функция для логирования
log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Проверка доступности удалённого сервера
log "Проверка доступности удалённого сервера ${REMOTE_HOST}..."
ping -c 1 "$REMOTE_HOST" > /dev/null
if [ $? -ne 0 ]; then
  log "Ошибка: сервер недоступен!"
  echo "Ошибка: сервер недоступен!"
  exit 1
fi

# Копирование файлов через scp
log "Передача файлов на удалённый сервер..."
for file in "${ARTIFACTS[@]}"; do
  if [ -f "$file" ]; then
    scp -q "$file" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/"
    if [ $? -ne 0 ]; then
      log "Ошибка при передаче файла: $file"
      echo "Ошибка при передаче файла: $file"
      exit 1
    fi
  else
    log "Ошибка: файл $file не найден!"
    echo "Ошибка: файл $file не найден!"
    exit 1
  fi
done

# Проверка файлов на удалённой машине
log "Проверка файлов на удалённом сервере..."
ssh -q "${REMOTE_USER}@${REMOTE_HOST}" "ls -l ${REMOTE_DIR}/s21_cat ${REMOTE_DIR}/s21_grep"
if [ $? -ne 0 ]; then
  log "Ошибка: проверка файлов на удалённой машине провалилась!"
  echo "Ошибка: проверка файлов на удалённой машине провалилась!"
  exit 1
fi

log "Деплой завершён успешно!"
echo "Деплой завершён успешно!"
exit 0
