---
name: feedback_no_builtin_web_research
description: Никогда не использовать встроенный WebSearch — только MCP-серверы (firecrawl/tavily/exa) или браузерный webwright
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 000a817c-74b7-4fa5-8300-becc393e5ff8
---

Встроенный веб-ресерч (`WebSearch`) пользователь запретил использовать **никогда** — «он ужасен и не собирает актуальную информацию».

**Чем заменять:**
- MCP-серверы поиска: `mcp__tavily__tavily_search` (есть фильтр по дате start_date/end_date, include_domains, search_depth=advanced), `mcp__firecrawl__firecrawl_search`, `mcp__exa__web_search_exa`.
- Браузерный поиск через **webwright** (Playwright, skill `webwright:webwright` / `/webwright:run`) — когда нужно реально зайти на страницу и достать точную формулировку/первоисточник.

**Why:** встроенный поиск даёт устаревшую и нерелевантную выдачу; у пользователя специально подключены MCP-серверы и webwright — их и надо использовать. Поймано 2026-06-24 на МояКоманда (проверка исследования hh.ru).

**How to apply:** для любой проверки факта/свежих данных сразу брать Tavily/firecrawl/exa; для точной выдержки со страницы — webwright. Не предлагать и не вызывать `WebSearch`. Связано с [[reference_webwright_venv]], [[feedback_таймбокс_ресерча]].
