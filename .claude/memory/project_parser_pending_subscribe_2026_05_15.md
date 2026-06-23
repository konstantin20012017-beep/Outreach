---
name: project-parser-pending-subscribe-2026-05-15
description: "🚨 Парсер — 26 чатов добавлены в авто_китай_чаты.txt, но пользователь НЕ успел подписаться (лимит TG). Напомнить в следующую сессию + задеплоить"
metadata: 
  node_type: memory
  type: project
  originSessionId: 6eac600a-61dd-43e4-a362-8a259df77f51
---

В `авто_китай_чаты.txt` локально добавлены 26 новых чатов (порция 2026-05-15 после ресёрча — VW/Skoda/Honda/Mazda/Mercedes/Audi/Nissan/Hyundai/Kia/Toyota/Geely/Subaru). На VPS ещё НЕ задеплоены. Пользователь поймал лимит TG на массовое вступление в группы — успел подписаться от @kreohunter только на часть.

**Why:** парсер не получит сообщения из чатов, в которые @kreohunter не вступил. Деплой без подписки = чаты будут резолвиться (или фейлиться), но трафика не будет.

**How to apply:** при следующем заходе в проект Парсер — первым делом напомнить пользователю «надо подписаться от @kreohunter на 26 новых чатов из `авто_китай_чаты.txt` (помечены комментом 'Добавлены 2026-05-15 порция 2')». После подтверждения что подписан на всех (или на каких — те и оставляем, остальные временно закомментировать) — деплой пакетом scp + systemctl restart parser. Сейчас на VPS крутится 23 чата. См. также [[project-parser-pending-deploy-2026-05-15]].

Список 26 добавленных чатов:
mazdacx5_club, tiguan_chat, vw_tayron, vwpolo2020, polo_club, skoda_superb_club_direct, octavia_club, civicclubhonda, Honda_CRV5, Mazda3chat, mazdaclubru_chat, mazda_forum, MercedesCLAchat, MercedesGLCru, mercedesbenz_group, audi_typ8_tech, clubnissan_qashqai, tucson_club, cerato_club, kiario_3, cerato3, rav4forum, rav4_50, club_atlaspro, geelyru, sticlubsu.

Файл-чеклист с галочками: `/Users/konstantinsabalin/Documents/Парсер/новые_чаты_кандидаты_v2.html` — состояние сохранено в localStorage, можно докликать остатки.
