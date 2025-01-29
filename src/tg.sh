variables:
  TELEGRAM_API: "https://api.telegram.org/bot${7456794509:AAGWuVhA_1odOJYw4sXwH6IkPj8GzX2r8rY}/sendMessage"

send_telegram_message:
  script:
    - |
      STATUS="✅ Успешно"
      if [ "$CI_JOB_STATUS" != "success" ]; then
        STATUS="❌ Ошибка"
      fi
      MESSAGE="🔔 *CI/CD Notification* 🔔
      
      📌 Проект: *${CI_PROJECT_NAME}*
      🔄 Ветка: *${CI_COMMIT_REF_NAME}*
      🚀 Pipeline ID: *${CI_PIPELINE_ID}*
      🔍 Job: *${CI_JOB_NAME}*
      💡 Статус: *${STATUS}*"

      curl -s -X POST "${TELEGRAM_API}" \
        -d chat_id="${419527685}" \
        -d text="${MESSAGE}" \
        -d parse_mode="Markdown"
  after_script:
    - send_telegram_message
