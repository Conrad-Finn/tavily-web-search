# Tavily Web Search

AI 驱动的实时网络搜索 API，专为 AI 代理设计，支持搜索结果和 AI 答案合成。

## 特性

- **免费使用**：每月 1000 次免费搜索额度
- **AI 答案合成**：自动生成搜索结果的 AI 摘要
- **实时搜索**：获取最新网络信息
- **深度研究**：支持全面深入的研究模式
- ** Claude Code 集成**：作为 skill 直接使用

## 前置要求

### 获取 Tavily API Key

1. 访问 https://tavily.com/ 注册账号
2. 在仪表板获取 API Key
3. 免费额度：1000 次/月

### 配置环境变量

**Claude Code 配置** (`~/.claude/settings.json`):
```json
{
  "env": {
    "TAVILY_API_KEY": "your-api-key"
  }
}
```

**Shell 配置**:
```bash
export TAVILY_API_KEY="your-api-key"
```

## 快速开始

### 基本搜索

```bash
./scripts/search.sh '{"query": "React hooks"}'
```

### 带 AI 答案的搜索

```bash
./scripts/search.sh '{"query": "AI trends 2026", "include_answer": true}'
```

### 深度研究

```bash
./scripts/search.sh '{"query": "machine learning", "max_results": 15, "include_answer": true, "search_depth": "comprehensive"}'
```

## 参数说明

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `query` | string | - | 搜索关键词（必填） |
| `include_answer` | boolean | false | 是否包含 AI 生成的摘要 |
| `max_results` | number | 10 | 返回结果数量，最大 20 |
| `search_depth` | string | "basic" | 搜索深度：`basic`（快速）或 `comprehensive`（深入） |
| `include_images` | boolean | false | 是否包含图片结果 |
| `include_raw_content` | boolean | false | 是否包含页面原始内容 |

## 使用场景

### 基础搜索

```bash
{"query": "latest technology news"}
```

### 研究任务

```bash
{"query": "impact of AI on software development", "include_answer": true}
```

### 深度研究

```bash
{"query": "quantum computing advances 2026", "search_depth": "comprehensive", "max_results": 15}
```

### 技术教程搜索

```bash
{"query": "React Server Components tutorial", "include_answer": true}
```

### 新闻监控

```bash
{"query": "AI news this week", "include_answer": true}
```

## 性能

- `search_depth: basic`：约 1-2 秒
- `search_depth: comprehensive`：约 3-5 秒

## 与其他工具对比

| API | 免费额度 | 付费价格 | 适用场景 |
|-----|----------|----------|----------|
| **Tavily** | 1000 次/月 | $5+/1000次 | AI 代理（推荐） |
| Nimble | 无 | ~$20/月 | 专注模式 |
| SerpAPI | 无 | $50+/月 | Google 搜索结果 |

Tavily 专为 AI 设计，推荐用于 AI 产品开发工作。

## 文档

- [使用案例](./examples/use-cases.md) - 8 种 AI 产品经理工作场景
- [API 参考](./references/api-reference.md) - 完整 API 文档和代码示例

## 许可证

Apache-2.0
