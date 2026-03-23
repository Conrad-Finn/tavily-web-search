---
name: tavily-web-search
description: >
  AI-powered web search API with real-time results and answer synthesis. Free
  tier: 1000 searches/day. Use when: researching topics, finding current
  information, gathering URLs, or needing AI-synthesized answers.
license: Apache-2.0
metadata:
  author: Conrad-Finn
  title: Tavily 免费搜索
  description_zh: AI 产品经理必备的免费搜索工具，每月 1000 次免费搜索
  version: 1.0.2
  license: Apache-2.0
---

# Tavily Web Search

AI-powered search API designed for AI agents with real-time results and answer synthesis.

## Prerequisites

**Tavily API Key Required** - Get your free key at https://tavily.com/

Free tier: 1000 searches/day (enough for most use cases)

Set `TAVILY_API_KEY` environment variable:

- Claude Code: `~/.claude/settings.json` with `"env": {"TAVILY_API_KEY": "your-key"}`
- Shell: `export TAVILY_API_KEY="your-key"`

## Quick Start

```bash
./scripts/search.sh '{"query": "React hooks"}'

# With AI answer
./scripts/search.sh '{"query": "AI trends 2026", "include_answer": true}'

# Deep research
./scripts/search.sh '{"query": "machine learning", "max_results": 15, "include_answer": true}'
```

## Key Parameters

- `query`: Search string (required)
- `include_answer`: `true` for AI-generated summary (recommended for research)
- `max_results`: Default `10`, max `20`
- `search_depth`: `"basic"` (fast) or `"comprehensive"` (slower but better)
- `include_images`: `true` to include image results
- `include_raw_content`: `true` to get full page content

## Use Cases

### Basic Search
```bash
{"query": "latest technology news"}
```

### Research with AI Answer
```bash
{"query": "impact of AI on software development", "include_answer": true}
```

### Deep Research
```bash
{"query": "quantum computing advances 2026", "search_depth": "comprehensive", "max_results": 15}
```

### Technical Search
```bash
{"query": "React Server Components tutorial", "include_answer": true}
```

### News Monitoring
```bash
{"query": "AI news this week", "include_answer": true}
```

## API Reference

**Endpoint:** `POST https://api.tavily.com/search`

**Request:**
```json
{
  "query": "search string",
  "include_answer": false,
  "max_results": 10,
  "search_depth": "basic"
}
```

**Response:**
```json
{
  "results": [{"url": "...", "title": "...", "content": "..."}],
  "answer": "AI summary (if include_answer=true)",
  "images": []
}
```

## Performance

- `search_depth: basic` → ~1-2 seconds
- `search_depth: comprehensive` → ~3-5 seconds

## Comparison with Alternatives

| API | Free Tier | Paid | Best For |
|-----|-----------|------|----------|
| **Tavily** | 1000/day | $5+/1000次 | AI agents (recommended) |
| Nimble | None | ~$20/月 | Focus modes |
| SerpAPI | None | $50+/月 | Google results |

Tavily is recommended for AI product work - free and designed for AI.

## More Resources

- `examples/use-cases.md` - 8 种 AI 产品经理工作场景
- `references/api-reference.md` - 完整 API 文档和代码示例
