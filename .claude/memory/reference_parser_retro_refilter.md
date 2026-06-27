---
name: reference_parser_retro_refilter
description: "Парсер — как ретро-прогонять накопленные лиды через Haiku (где запускать, чем читать канал)"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 437d673a-9e1c-41f9-8d99-48dc09a74c23
---

Ретро-фильтрация накопленных лидов ниши (когда ниша копила без AI-фильтра, ai_filter=false, и надо отобрать «нормальные» постфактум). Три грабли, на которые наступили 2026-06-25 (ниша «Контент», 978 лидов → 196 уникальных → 21 одобрено Haiku, 🔥15):

1. **Локальная машина (РФ) НЕ достаёт Telegram MTProto** — Telethon-коннект виснет навсегда (0 TCP, ~0 CPU). РКН режет не только RU-VPS, но и локальный домашний интернет. → Любой Telethon-код гонять ТОЛЬКО на зарубежном VPS (CZ `85.137.165.185`), не локально. См. [[reference_russian_vps_telegram_block]].

2. **Локальный `.env` содержит СТАРЫЙ (удалённый) Anthropic-ключ** → 401 invalid x-api-key. Действующий ключ живёт только в `/opt/parser/.env` на VPS. → Вызовы Haiku/anthropic тоже гонять на VPS (он достаёт api.anthropic.com), секрет на локалку не тащить.

3. **Аккаунт парсера @kreohunter НЕ состоит в каналах выдачи** (лиды кладёт бот через Bot API, сам аккаунт туда не вступал) → Telethon `iter_messages` падает `Could not find input entity`. Bot API историю не отдаёт. → Чтобы прочитать историю канала выдачи: пользователь делает экспорт Telegram Desktop (Machine-readable JSON, `result.json`), а скрипт парсит его офлайн. Скрипты: `refilter.py` (через Telethon, на VPS) и `refilter_export.py` (из JSON-экспорта; принимает путь аргументом). Оба переиспользуют `build_html`/`classify`. Текст лида в экспорте лежит между заголовком «Заявка — <Ниша>» и разделителем «━━━»; ссылка — в `text_entities` type=`text_link`.

Рабочая схема прогона экспорта: scp `result.json` + `refilter_export.py` на VPS → `python refilter_export.py export.json` → HTML пишется на VPS → `cp` в ASCII-имя → scp обратно → `open -a "Google Chrome"` локально.
