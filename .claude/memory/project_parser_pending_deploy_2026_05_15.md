---
name: project-parser-pending-deploy-2026-05-15
description: "Парсер — 6 файлов локально готовы, на VPS старая версия. Напомнить пользователю задеплоить при следующем заходе в проект Парсер."
metadata: 
  node_type: memory
  type: project
  originSessionId: 7f9d77c3-2ed8-4094-89b6-9284b9694912
---

**На 2026-05-15 18:30 локально обновлены, на VPS НЕ залиты:**
- `main.py` (антиключи в пайплайне + счётчик antikey_blocked)
- `filter.py` (новый промпт под критерии клиента: только Китай / ≤5 лет / ≤160 л.с. / левый руль / НЕ китайские бренды КРОМЕ Haval и Geely + список 45 моделей)
- `config.py` (загрузка антиключей)
- `авто_китай_ключи.txt` (+85 моделей → 332 ключа)
- `авто_китай_антиключи.txt` (новый файл, 44 стопа)
- `авто_китай_чаты.txt` (+4 чата → 23 чата)

**Команды для деплоя (пользователь запускает сам, root-пароль у него):**

```
scp "/Users/konstantinsabalin/Documents/Парсер/main.py" "/Users/konstantinsabalin/Documents/Парсер/filter.py" "/Users/konstantinsabalin/Documents/Парсер/config.py" "/Users/konstantinsabalin/Documents/Парсер/авто_китай_ключи.txt" "/Users/konstantinsabalin/Documents/Парсер/авто_китай_антиключи.txt" "/Users/konstantinsabalin/Documents/Парсер/авто_китай_чаты.txt" root@85.137.165.185:/opt/parser/

ssh root@85.137.165.185 'systemctl restart parser && sleep 2 && systemctl status parser --no-pager | head -15 && tail -40 /var/log/parser.log'
```

**Why:** клиент дал критичные уточнения по нише (Владислав, 15.05 10:51) — без деплоя парсер шлёт лиды по китайским брендам, праворукие, старые машины, которые клиент не возит. После деплоя ожидаем резкий рост точности.

**How to apply:** при следующем заходе пользователя в проект Парсер — первым делом спросить «деплоить будем?» и показать команды. Если деплой произошёл — удалить этот файл из памяти.

См. [[project-parser-telegram]].
