---
name: HTML-цепочки — паттерн чистого копирования в Google Docs
description: Скрипт copyBlock должен клонировать узел и вырезать UI-элементы (.copy-btn, .seg-divider) перед записью в буфер, иначе текст кнопок и разделителей попадает в Google Docs
type: feedback
originSessionId: c1cd0442-cce0-46ec-8f2c-99b648b47723
---
При создании HTML-файлов с цепочками писем для копирования в Google Docs использовать паттерн с клонированием + удалением UI:

```js
async function copyBlock(id, btn) {
  const el = document.getElementById(id);
  const clone = el.cloneNode(true);
  clone.querySelectorAll('.copy-btn, .seg-divider').forEach(n => n.remove());
  const temp = document.createElement('div');
  temp.style.cssText = 'position:fixed;left:-9999px;top:0;';
  temp.appendChild(clone);
  document.body.appendChild(temp);
  const html = clone.innerHTML;
  const text = clone.innerText;
  document.body.removeChild(temp);
  await navigator.clipboard.write([
    new ClipboardItem({
      'text/html': new Blob([html], {type: 'text/html'}),
      'text/plain': new Blob([text], {type: 'text/plain'})
    })
  ]);
}
```

**Why:** В первой версии Ravix-цепочек скрипт копировал innerHTML/innerText напрямую — в Google Docs попадали слова «Копировать» (текст кнопок внутри карточек) и текст синих разделителей-навигации. Пользователь увидел дубликаты «Сегмент №1 — Фитнес-клубы» (разделитель) + «Сегмент №1. Фитнес-клубы» (заголовок) и кнопки «Копировать» в потоке текста.

**How to apply:**
- Любые UI-элементы внутри копируемой области (кнопки, навигация, бейджи, разделители) помечать классами `.copy-btn`, `.seg-divider` или подобными.
- В `copyBlock` всегда клонировать и вырезать эти классы перед записью в буфер.
- Временно вставлять клон в DOM (offscreen) — иначе `innerText` отдаст текст без переносов строк.
- Inline-стили на текстовых блоках (Arial 11pt body, Arial 18pt bold для h2) обязательны — Google Docs читает text/html и применяет их при вставке.
