#!/usr/bin/env bash
# Tavily Web Search - Agent Skill Wrapper
# Usage:
#   ./scripts/search.sh "search query"           # Simple query
#   ./scripts/search.sh "search query" answer    # With AI answer
#   ./scripts/search.sh "search query" 10        # With max results
#   ./scripts/search.sh "search query" answer 15 # All options

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_error() { echo -e "${RED}Error: $1${NC}" >&2; }
print_info() { echo -e "${GREEN}$1${NC}"; }
print_success() { echo -e "${YELLOW}$1${NC}"; }

# Check for API key
if [ -z "${TAVILY_API_KEY:-}" ]; then
    print_error "TAVILY_API_KEY not set"
    echo ""
    echo "Get your free API key at: https://tavily.com/"
    echo ""
    echo "Configure:"
    echo '  {"env": {"TAVILY_API_KEY": "your-key"}}'
    exit 1
fi

# Parse arguments - support natural language
if [ $# -eq 0 ]; then
    echo "Usage: $0 <search query> [answer] [max_results]"
    echo ""
    echo "Examples:"
    echo "  $0 'React hooks'"
    echo "  $0 'AI news 2026' answer"
    echo "  $0 'product management' answer 10"
    echo ""
    exit 1
fi

QUERY="$1"
INCLUDE_ANSWER="false"
MAX_RESULTS="10"

# Parse optional arguments
if [ $# -ge 2 ]; then
    if [ "$2" = "answer" ]; then
        INCLUDE_ANSWER="true"
        [ $# -ge 3 ] && MAX_RESULTS="$3"
    else
        MAX_RESULTS="$2"
    fi
fi

# Build JSON
JSON=$(jq -n \
    --arg query "$QUERY" \
    --arg answer "$INCLUDE_ANSWER" \
    --arg max "$MAX_RESULTS" \
    '{
        query: $query,
        include_answer: ($answer == "true"),
        max_results: ($max | tonumber)
    }')

# Add api_key
JSON_WITH_KEY=$(echo "$JSON" | jq --arg key "$TAVILY_API_KEY" '. + {api_key: $key}')

print_info "Searching: $QUERY"

# Make request
RESULT=$(curl -s -X POST "https://api.tavily.com/search" \
    -H "Content-Type: application/json" \
    -d "$JSON_WITH_KEY")

# Check for errors
if echo "$RESULT" | jq -e '.detail' >/dev/null 2>&1; then
    print_error "$(echo "$RESULT" | jq -r '.detail')"
    exit 1
fi

# Format output
RESPONSE_TIME=$(echo "$RESULT" | jq -r '.response_time')
TOTAL_RESULTS=$(echo "$RESULT" | jq '.results | length')

echo ""
echo "=== 搜索结果 ($TOTAL_RESULTS 条, ${RESPONSE_TIME}s) ==="
echo ""

# Print answer if available
if [ "$INCLUDE_ANSWER" = "true" ]; then
    ANSWER=$(echo "$RESULT" | jq -r '.answer')
    if [ "$ANSWER" != "null" ] && [ -n "$ANSWER" ]; then
        echo "📝 AI 摘要:"
        echo "$ANSWER"
        echo ""
        echo "---"
        echo ""
    fi
fi

# Print results
echo "$RESULT" | jq -r '.results[] | "## [\(.title)](\(.url))\n\(.content[0:300])...\n"' | head -c 3000

echo ""
echo "=== 来源 ==="
echo "$RESULT" | jq -r '.results[] | "- \(.url)"'

# ============================================
# Auto-save results to file
# ============================================

# Create save directory (by date)
DATE_DIR=$(date +"%Y-%m-%d")
SAVE_DIR="./search_results/${DATE_DIR}"
mkdir -p "$SAVE_DIR"

# Generate filename from query (sanitized)
FILENAME=$(echo "$QUERY" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-//;s/-$//')
TIMESTAMP=$(date +"%H%M%S")
SAVE_FILE="${SAVE_DIR}/${FILENAME}_${TIMESTAMP}.md"

# Build markdown content
{
    echo "# $QUERY"
    echo ""
    echo "**搜索时间**: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "**结果数量**: $TOTAL_RESULTS 条"
    echo "**响应时间**: ${RESPONSE_TIME}s"
    echo ""

    if [ "$INCLUDE_ANSWER" = "true" ]; then
        ANSWER=$(echo "$RESULT" | jq -r '.answer')
        if [ "$ANSWER" != "null" ] && [ -n "$ANSWER" ]; then
            echo "## AI 摘要"
            echo ""
            echo "$ANSWER"
            echo ""
        fi
    fi

    echo "## 搜索结果"
    echo ""
    echo "$RESULT" | jq -r '.results[] | "- [\(.)](\(.url))"'
    echo ""
    echo "## 原始数据"
    echo ""
    echo '```json'
    echo "$RESULT" | jq .
    echo '```'
} > "$SAVE_FILE"

print_success "✅ 结果已保存到: $SAVE_FILE"
