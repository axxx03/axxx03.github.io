#!/bin/bash

# 博客状态检查脚本

BLOG_DIR="/Users/rongwei/Note/academicpages.github.io"
cd "$BLOG_DIR" || exit 1

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}   博客状态检查${NC}"
echo -e "${GREEN}========================================${NC}"

# 检查端口
echo -e "\n${YELLOW}检查端口 4000...${NC}"
if lsof -ti:4000 > /dev/null 2>&1; then
    PORT_PID=$(lsof -ti:4000)
    echo -e "${GREEN}✓ 端口 4000 正在使用 (PID: $PORT_PID)${NC}"
else
    echo -e "${RED}✗ 端口 4000 未被占用${NC}"
fi

# 检查 Docker 容器
echo -e "\n${YELLOW}检查 Docker 容器...${NC}"
if docker-compose ps 2>/dev/null | grep -q "Up"; then
    echo -e "${GREEN}✓ Docker 容器正在运行${NC}"
    docker-compose ps
else
    echo -e "${RED}✗ Docker 容器未运行${NC}"
fi

# 检查 HTTP 响应
echo -e "\n${YELLOW}检查 HTTP 响应...${NC}"
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:4000 2>/dev/null)
if [ "$HTTP_CODE" = "200" ]; then
    echo -e "${GREEN}✓ 博客可访问 (HTTP $HTTP_CODE)${NC}"
    echo -e "${GREEN}访问地址: http://localhost:4000${NC}"
elif [ -n "$HTTP_CODE" ]; then
    echo -e "${YELLOW}⚠ HTTP 响应码: $HTTP_CODE${NC}"
else
    echo -e "${RED}✗ 无法连接到博客${NC}"
fi

# 显示最新日志
echo -e "\n${YELLOW}最新日志 (最后 5 行):${NC}"
docker-compose logs --tail=5 2>/dev/null || echo "无法获取日志"

echo -e "\n${GREEN}========================================${NC}"

