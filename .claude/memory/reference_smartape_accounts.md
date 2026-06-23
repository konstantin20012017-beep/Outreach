---
name: reference-smartape-accounts
description: "У пользователя два аккаунта SmartApe — старый sub-user без прав покупки, новый под парсер"
metadata: 
  node_type: memory
  type: reference
  originSessionId: c553fcb1-ca12-48a3-bb19-9a3cd7af6098
---

**Старый аккаунт SmartApe:** там крутится исходный парсер ассистента (420 ₽/мес). У пользователя в нём логин с правами sub-user — нельзя покупать новые услуги (айтишник так настроил). Доступен только биллинг и TG-аккаунт.

**Новый аккаунт SmartApe** (зарегистрирован 2026-05-14):
- Логин: `shabalin.konstantin2012@yandex.ru`
- Под него куплен VPS HDD S1 (заказ #1634364, IP 188.127.254.194) для нового парсера.
- Реквизиты VPS (root-пароль, VMmanager-пароль) — в `.env` проекта `/Users/konstantinsabalin/Documents/Парсер/`.

**How to apply:** при любых задачах деплоя/покупки услуг под парсер — работаем с новым аккаунтом. Старый не трогаем (на нём боевой парсер ассистента).

См. [[project-parser-telegram]].
