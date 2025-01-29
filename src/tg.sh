#!/bin/bash

# НИКОГДА НЕ ХРАНИТЬ ТАК ДАННЫЕ!!!!
TELEGRAM_BOT_TOKEN="7456794509:AAGWuVhA_1odOJYw4sXwH6IkPj8GzX2r8rY"
TELEGRAM_CHAT_ID="419527685"

# Проверка наличия переменных
if [[ -z "$TELEGRAM_BOT_TOKEN" || -z "$TELEGRAM_CHAT_ID" ]]; then
  echo "Ошибка: TELEGRAM_BOT_TOKEN или TELEGRAM_CHAT_ID не заданы!"
  exit 1
fi

# Определение статуса
if [[ "$CI_JOB_STATUS" == "success" ]]; then
  STATUS="✅ Успешно"
else
  STATUS="❌ Ошибка"
fi

# Формирование сообщения
MESSAGE="🔔 *CI/CD Notification*  
📌 Проект: *${CI_PROJECT_NAME}*  
🔄 Ветка: *${CI_COMMIT_REF_NAME}*  
🔧 Джоб: *${CI_JOB_NAME}*  
💡 Статус: *${STATUS}*"

# Отправка уведомления в Telegram
curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
  -d chat_id="${TELEGRAM_CHAT_ID}" \
  -d text="${MESSAGE}" \
  -d parse_mode="Markdown"

