---
name: reference-russian-vps-telegram-block
description: На российских VPS Telegram MTProto-трафик режется РКН — для парсеров на Telethon брать зарубежные ДЦ
metadata: 
  node_type: memory
  type: reference
  originSessionId: 50458a48-b328-4539-bfc9-718f17bd7eae
---

**Факт:** на VPS в российских ДЦ (как минимум DataPro Moscow у SmartApe, проверено 2026-05-14) исходящий трафик к MTProto-серверам Telegram (149.154.167.50, 149.154.175.50, 91.108.56.165, 95.161.76.100 — порт 443) полностью режется. Обычный HTTPS-трафик (Google, даже telegram.org частично) при этом работает.

**Why:** РКН после 2022 года продолжает фильтрацию Telegram-трафика на уровне магистрали РФ, несмотря на формальную разблокировку 2020 года.

**How to apply:**
- Для Telethon/aiogram/любого MTProto-клиента на сервере — сразу брать зарубежный ДЦ (Hetzner DE, SmartApe Host-Telecom CZ, Aeza зарубеж, Timeweb Cloud Amsterdam).
- Если уже куплен RU VPS — можно поставить MTProto/SOCKS5 прокси, но это костыль и +1-3$/мес.
- Проверка перед деплоем: `timeout 5 bash -c "</dev/tcp/149.154.167.50/443"` — если FAIL, MTProto заблокирован.

См. [[project-parser-telegram]] — конкретный кейс, на котором это вылезло.
