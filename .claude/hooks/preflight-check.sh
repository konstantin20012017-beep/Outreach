#!/bin/bash
# Блокирует Write/Edit по цепочки/*.html, если в файле нет маркера <!-- PREFLIGHT-OK -->
# Маркер вставляется только после того, как в чате выведен блок PRE-FLIGHT с source-check.

input=$(cat)
tool_name=$(echo "$input" | jq -r '.tool_name')

if [[ "$tool_name" != "Write" && "$tool_name" != "Edit" ]]; then
  exit 0
fi

file_path=$(echo "$input" | jq -r '.tool_input.file_path')

case "$file_path" in
  */цепочки/*.html) ;;
  *) exit 0 ;;
esac

if [[ "$tool_name" == "Write" ]]; then
  content=$(echo "$input" | jq -r '.tool_input.content')
  if echo "$content" | grep -q "PREFLIGHT-OK"; then
    exit 0
  fi
else
  # Edit: разрешаем, если маркер уже есть в существующем файле
  if [[ -f "$file_path" ]] && grep -q "PREFLIGHT-OK" "$file_path"; then
    exit 0
  fi
  # либо если новый блок Edit'а сам добавляет маркер
  new_string=$(echo "$input" | jq -r '.tool_input.new_string')
  if echo "$new_string" | grep -q "PREFLIGHT-OK"; then
    exit 0
  fi
fi

cat >&2 <<'EOF'
БЛОКИРОВКА: запись в цепочки/*.html без PRE-FLIGHT.

Прежде чем писать файл цепочки:
1. Выведи в чат блок PRE-FLIGHT:
   - все конкретные утверждения каждого письма списком
   - каждое помечено ✓ источник или ✗ домысел
   - все ✗ — вырезать / переформулировать / в warning
   - таблица разводки сегментов (если их 2+): по 4 осям, не лексика
   - CTA-лестница: №1 лёгкий, №2 средний, №3 тяжёлый или обнуляющий
2. После блока в чате — вставь в HTML маркер: <!-- PREFLIGHT-OK -->
   (например, сразу после <head> или комментарием в начале body)
3. Только после этого Write пройдёт.
EOF
exit 2
