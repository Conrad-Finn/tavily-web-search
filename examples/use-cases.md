# Tavily Web Search - 使用案例

本文档展示 Tavily Search API 在 AI 产品工作中的实际应用场景。

## 1. PRD 调研场景

### 竞品功能调研

```bash
./scripts/search.sh "notion AI features vs obsidian AI 2026" answer
```

**产品经理用途**：了解竞品 AI 功能特性，辅助产品规划

### 市场趋势调研

```bash
./scripts/search.sh "AI note taking app market trends 2026" answer 10
```

**产品经理用途**：判断市场空间和增长机会

---

## 2. 用户研究场景

### 用户痛点挖掘

```bash
./scripts/search.sh "product managers biggest challenges 2026" answer
```

**产品经理用途**：了解目标用户核心痛点

### 行业案例收集

```bash
./scripts/search.sh "AI product success stories case studies" answer 8
```

**产品经理用途**：寻找可借鉴的成功案例

---

## 3. 技术调研场景

### 技术选型调研

```bash
./scripts/search.sh "React vs Vue vs Svelte 2026 comparison" answer
```

**产品经理用途**：评估技术方案可行性

### AI 能力边界探索

```bash
./scripts/search.sh "LLM limitations current problems 2026" answer
```

**产品经理用途**：了解技术边界，合理设计产品功能

---

## 4. 竞品监控场景

### 竞品动态追踪

```bash
./scripts/search.sh "notion new features 2026" answer
```

**产品经理用途**：持续监控竞品更新

### 行业新闻汇总

```bash
./scripts/search.sh "AI productivity tools news this week" answer
```

**产品经理用途**：保持行业敏感度

---

## 5. 内容创作场景

### 博客主题灵感

```bash
./scripts/search.sh "trending AI product management topics" answer
```

**产品经理用途**：寻找内容创作方向

### 行业术语解释

```bash
./scripts/search.sh "what is RAG retrieval augmented generation simple explanation" answer
```

**产品经理用途**：快速理解技术概念

---

## 6. 面试准备场景

### 职位要求调研

```bash
./scripts/search.sh "AI product manager interview questions 2026" answer
```

**产品经理用途**：准备面试

### 薪资范围调研

```bash
./scripts/search.sh "AI product manager salary range 2026" answer
```

**产品经理用途**：了解市场薪资水平

---

## 7. 投资研究场景

### 赛道分析

```bash
./scripts/search.sh "AI agents startups funding 2026" answer 10
```

**产品经理用途**：了解投资热点和创业机会

### 公司研究

```bash
./scripts/search.sh "Anthropic Claude products strategy" answer
```

**产品经理用途**：研究标杆公司战略

---

## 8. 多维度调研模板

### 完整竞品分析流程

```bash
# 1. 产品概述
./scripts/search.sh "[竞品名] product overview features" answer

# 2. 定价策略
./scripts/search.sh "[竞品名] pricing plans 2026" answer

# 3. 用户评价
./scripts/search.sh "[竞品名] user reviews G2 Capterra" answer

# 4. 最新动态
./scripts/search.sh "[竞品名] news updates 2026" answer
```

---

## 使用技巧

1. **用 answer 参数获取摘要** - 快速了解内容要点
2. **用 max_results 控制数量** - 5-10 条适合快速浏览，15-20 适合深度研究
3. **用中文搜索** - Tavily 对中文支持良好
4. **组合关键词** - 如 "AI product manager" + "2026" + "trends"
