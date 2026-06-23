---
name: reference_pptx_office_extract
description: Как вытащить текст из присланных .pptx (и office) когда python-pptx нет — через zipfile+xml
metadata: 
  node_type: memory
  type: reference
  originSessionId: 702b9010-884c-4545-b021-c29917eb0a39
---

Клиент часто присылает материалы презентациями (.pptx) — конкурентный анализ, бренд-стратегия, КП (правило #6 CLAUDE.md — изучить ВСЁ до текста). `python-pptx` в окружении обычно НЕ установлен (ставить пакеты нельзя). Решение — .pptx это zip из XML, текст тянется stdlib-ом (`zipfile` + `xml.etree`).

**Рабочий скрипт (проверено МояКоманда 2026-06-17, лежит в `Парсер/extract_pptx.py`):**
```python
import zipfile, re, sys, os
from xml.etree import ElementTree as ET
A = '{http://schemas.openxmlformats.org/drawingml/2006/main}'
for path in sys.argv[1:]:
    z = zipfile.ZipFile(path)
    slides = sorted([n for n in z.namelist() if re.match(r'ppt/slides/slide\d+\.xml$', n)],
                    key=lambda x: int(re.search(r'(\d+)', x).group()))
    for i, s in enumerate(slides, 1):
        root = ET.fromstring(z.read(s))
        for p in root.iter(A+'p'):
            line = ''.join(t.text for t in p.iter(A+'t') if t.text).strip()
            if line: print(line)
```
Запуск: `python extract_pptx.py "файл.pptx"` (любой python со stdlib; в этом окружении — `Парсер/.ww-venv/bin/python`, см. [[reference_webwright_venv]]).

**Прочие office-форматы (стдлибом/нативно, без pip):**
- `.docx` → `textutil -convert txt -stdout file.docx` (macOS-нативный).
- `.xlsx` → `openpyxl` (обычно есть; CLAUDE.md #6 упоминает).
- `.pdf` → `pdftotext -layout file.pdf -`.

**Гримасы:** файлы на Рабочем столе часто с пробелом перед расширением («Конкурентный анализ .pptx») и кавычками-ёлочками в имени — находить через `find ~/Desktop -iname "*.pptx"`, путь брать в кавычки. Картинки/диаграммы из слайдов так не тянутся — только текст (для брифа достаточно).

Связано с [[reference_google_docs_drive_extract]] (тот же класс задач — выгрузка присланных материалов), [[feedback_следовать_указанному_инструменту]].
