---
name: reference_webwright_venv
description: "Playwright для webwright-обходов сайтов живёт в Парсер/.ww-venv/bin/python, не глобально"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 702b9010-884c-4545-b021-c29917eb0a39
---

Когда клиент просит обойти сайт через playwright/webwright (правило следовать инструменту — [[feedback_следовать_указанному_инструменту]]), готовое окружение Playwright уже стоит в проекте Парсер:

- **Интерпретатор:** `Парсер/.ww-venv/bin/python` (НЕ глобальный python3 — там playwright не установлен; НЕ `Парсер/venv/` — это venv телеграм-парсера).
- Firefox через Playwright запускается (`p.firefox.launch(headless=True)`), Chromium иногда падает с `ERR_HTTP2_PROTOCOL_ERROR`.
- Скрипты обхода складывать в `Парсер/<проект>_scrape/final_runs/run_<id>/` (texts/ + screenshots/), как jubga_scrape и moyakomanda_scrape.
- Скрипты массового обхода (26+ страниц) гнать `run_in_background`, ждать через until-loop по маркеру «DONE» в выводе, не sleep-цепочкой.

Проверено: jubga_scrape (2026-06-17), moyakomanda_scrape (2026-06-17, 26 страниц сайта моякоманда.рф).

Связано с [[reference_pptx_office_extract]], [[feedback_таймбокс_ресерча]].
