#!/bin/bash

# НИКОГДА НЕ ХРАНИТЬ ТАК ДАННЫЕ!!!!
# TELEGRAM_BOT_TOKEN="7456794509:AAGWuVhA_1odOJYw4sXwH6IkPj8GzX2r8rY"
# TELEGRAM_CHAT_ID="419527685"

URL="https://api.telegram.org/bot7456794509:AAGWuVhA_1odOJYw4sXwH6IkPj8GzX2r8rY/sendMessage"

TEXT="CI/CD STATUS: $1%0A%0AProject: $CI_PROJECT_NAME%0A%0AURL: $CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID/%0A%0AStatus: $CI_JOB_STATUS"

curl -s -d "chat_id=419527685&web_page_preview=1&text=$TEXT" $URL > /dev/null
