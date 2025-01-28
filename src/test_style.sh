#!/bin/bash

#cd src/cat
#clang-format -n *.c
#cd ../grep
#clang-format -n *.c

EXIT_CODE=0

# Проверка cat
echo "======================================"
echo "Проверка кодстайла в папке cat:"
echo "..."
cd cat || exit 1
# Вывод результата теста записываеться в переменную OUTPUT.
# если вывод не пустой то ошибка печатаеться.
OUTPUT=$(clang-format -n *.c 2>&1)
if [ -n "$OUTPUT" ]; then
  echo "Ошибка кодстайла в папке cat!"
  echo "$OUTPUT"
  EXIT_CODE=1
else
  echo "Тест кодстайла в папке cat прошел успешно!"
fi
cd ..

# Проверка папки grep
echo "======================================"
echo "Проверка кодстайла в папке grep:"
echo "..."
cd grep || exit 1
OUTPUT=$(clang-format -n *.c 2>&1)
if [ -n "$OUTPUT" ]; then
  echo "Ошибка кодстайла в папке grep!"
  echo "$OUTPUT"
  EXIT_CODE=1
else
  echo "Тест кодстайла в папке grep прошел успешно!"
fi
echo "======================================"
cd ..

# Код завершения
exit $EXIT_CODE

