---
name: reference_google_docs_drive_extract
description: "Как вытащить контент из присланных ссылок Google Docs / Drive (export txt, uc download, pdftotext, textutil)"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 72e5d29c-7a91-408f-8550-266caeac85e4
---

Когда клиент присылает материалы ссылками на Google Docs / Drive (правило #6 CLAUDE.md — изучить ВСЁ до написания текста), их можно выгрузить без авторизации, если открыт доступ по ссылке. Проверено на Re:activno 2026-06-08 (договор, портрет клиента, прогноз, 14 кейсов).

**Google Doc (нативный документ):**
```
curl -sL "https://docs.google.com/document/d/<ID>/export?format=txt" -o out.txt
```

**Файл на Drive (загруженный PDF/DOCX) — по file ID:**
```
curl -sSL "https://drive.google.com/uc?export=download&id=<ID>" -A "Mozilla/5.0" -o file.pdf
```
- zsh ломает `&` в переменной цикла → оборачивать URL в bash-функцию с позиционным `"$1"`, не гнать `$id` напрямую в цикле (иначе HTTP 000 / «Malformed input to a URL function»).

**Список файлов папки Drive + их ID:**
```
curl -sL "https://drive.google.com/drive/folders/<FOLDER_ID>" -A "Mozilla/5.0" -o folder.html
# имена: grep aria-label="...(docx|pdf)..."; ID: python regex по folder.html на токены [A-Za-z0-9_-]{28,44}, начинающиеся с '1'
```

**Распознать содержимое:**
- PDF → `pdftotext -layout file.pdf -` (кейсы Re:activno были текстовые, не картинки — распозналось).
- DOCX → `textutil -convert txt -stdout file.docx` (macOS-нативный, конвертит Word).

**Чего не вытащить так:** видео (Яндекс.Диск/прочее) — если клиент сам говорит «не смотри» (Re:activno: созвон «продажный, тебе не надо»), пропустить и зафиксировать. Иначе — просить текст/скриншот (правило #6).

Связано с [[feedback_отдавать_добытый_артефакт]], [[feedback_таймбокс_ресерча]].
