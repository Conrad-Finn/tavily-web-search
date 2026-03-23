# Tavily API 参考文档

## API 基础信息

| 项目 | 值 |
|------|-----|
| 基础 URL | `https://api.tavily.com/search` |
| 认证方式 | 请求体中传递 `api_key` |
| 免费额度 | 1000 次/天 |
| 响应格式 | JSON |

## 请求参数

| 参数 | 类型 | 必填 | 默认值 | 说明 |
|------|------|------|--------|------|
| `api_key` | string | 是 | - | 你的 Tavily API Key |
| `query` | string | 是 | - | 搜索查询字符串 |
| `include_answer` | boolean | 否 | false | 是否包含 AI 生成的摘要 |
| `max_results` | integer | 否 | 10 | 返回结果数量 (1-20) |
| `search_depth` | string | 否 | "basic" | 搜索深度: "basic" 或 "comprehensive" |
| `include_images` | boolean | 否 | false | 是否包含图片结果 |
| `include_raw_content` | boolean | 否 | false | 是否包含原始页面内容 |

## search_depth 参数说明

| 值 | 响应时间 | 适用场景 |
|----|----------|----------|
| `basic` | ~1秒 | 快速搜索、URL 发现 |
| `comprehensive` | ~3-5秒 | 深度研究、需要全面信息 |

## 响应字段

```json
{
  "query": "搜索查询",
  "answer": "AI 摘要 (当 include_answer=true)",
  "results": [
    {
      "url": "https://...",
      "title": "页面标题",
      "content": "页面内容摘要",
      "score": 0.95,
      "raw_content": "原始内容 (当 include_raw_content=true)"
    }
  ],
  "images": ["图片URL列表"],
  "response_time": 1.23,
  "request_id": "请求ID"
}
```

## 常用组合

### 快速 URL 发现

```json
{
  "query": "React hooks tutorial",
  "max_results": 5
}
```

### 带 AI 摘要的研究

```json
{
  "query": "AI product management trends 2026",
  "include_answer": true,
  "max_results": 10
}
```

### 深度研究

```json
{
  "query": "machine learning interpretability methods",
  "search_depth": "comprehensive",
  "include_answer": true,
  "max_results": 15,
  "include_raw_content": true
}
```

### 图片搜索

```json
{
  "query": "product design UI examples",
  "include_images": true,
  "max_results": 10
}
```

## 错误处理

### 常见错误

| 错误 | 原因 | 解决方案 |
|------|------|----------|
| `Unauthorized` | API Key 无效 | 检查 TAVILY_API_KEY |
| `Rate limit exceeded` | 超出配额 | 等待或升级套餐 |
| `Invalid query` | 查询格式错误 | 检查 query 参数 |

### Python 示例

```python
import requests

def search(query, include_answer=True, max_results=10):
    url = "https://api.tavily.com/search"
    data = {
        "api_key": "tvly-xxx",
        "query": query,
        "include_answer": include_answer,
        "max_results": max_results
    }
    response = requests.post(url, json=data)
    return response.json()

# 使用
result = search("AI product manager trends")
print(result["answer"])  # AI 摘要
print(result["results"]) # 搜索结果
```

### Node.js 示例

```javascript
const fetch = require('node-fetch');

async function search(query, options = {}) {
  const url = 'https://api.tavily.com/search';
  const body = {
    api_key: 'tvly-xxx',
    query,
    include_answer: options.includeAnswer ?? true,
    max_results: options.maxResults ?? 10,
    search_depth: options.searchDepth ?? 'basic'
  };

  const response = await fetch(url, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body)
  });

  return response.json();
}

// 使用
const result = await search('AI trends 2026');
console.log(result.answer);
```

## 配额和限制

| 套餐 | 每日限额 | 速率限制 |
|------|----------|----------|
| Free | 1000 次/天 | 1 请求/秒 |
| Pro | 10000 次/天 | 10 请求/秒 |
| Enterprise | 自定义 | 自定义 |

## 官方资源

- 官网: https://tavily.com/
- 文档: https://docs.tavily.com/
- Python SDK: `pip install tavily`
