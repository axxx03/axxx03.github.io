#!/bin/bash

# Jekyll 博客启动脚本
# 使用方法: ./start.sh [docker|local]
# 默认使用 docker 方式

BLOG_DIR="/Users/rongwei/Note/academicpages.github.io"
cd "$BLOG_DIR" || exit 1

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}   Jekyll 博客启动脚本${NC}"
echo -e "${GREEN}========================================${NC}"

# 停止可能正在运行的进程
echo -e "${YELLOW}检查并停止已运行的进程...${NC}"
lsof -ti:4000 | xargs kill -9 2>/dev/null || true
docker-compose down 2>/dev/null || true
echo -e "${GREEN}✓ 已清理旧进程${NC}"

# 获取启动方式参数，默认为 docker
# 如果指定了 auto，会自动选择可用的方式
MODE=${1:-docker}

# 自动模式：检测 Docker 是否可用，不可用时尝试本地方式
if [ "$MODE" = "auto" ] || [ -z "$1" ]; then
    if command -v docker &> /dev/null && docker ps > /dev/null 2>&1; then
        MODE="docker"
        echo -e "${GREEN}自动检测: 使用 Docker 方式${NC}"
    elif command -v docker &> /dev/null; then
        echo -e "${YELLOW}检测到 Docker 已安装，但 Docker daemon 未运行${NC}"
        echo -e "${YELLOW}请启动 Docker Desktop，然后运行: ./start.sh docker${NC}"
        echo -e "${YELLOW}或继续尝试本地方式...${NC}"
        MODE="local"
    else
        MODE="local"
        echo -e "${YELLOW}自动检测: Docker 未安装，尝试本地方式${NC}"
    fi
fi

if [ "$MODE" = "docker" ]; then
    echo -e "${YELLOW}使用 Docker 方式启动...${NC}"
    
    # 检查 Docker 是否安装
    if ! command -v docker &> /dev/null; then
        echo -e "${RED}错误: 未找到 Docker 命令${NC}"
        echo -e "${YELLOW}请先安装 Docker Desktop${NC}"
        echo -e "${YELLOW}或使用本地方式: ./start.sh local${NC}"
        exit 1
    fi
    
    # 检查 Docker daemon 是否运行
    if ! docker ps > /dev/null 2>&1; then
        echo -e "${RED}错误: Docker daemon 未运行${NC}"
        echo -e "${YELLOW}请先启动 Docker Desktop${NC}"
        echo -e "${YELLOW}或使用本地方式: ./start.sh local${NC}"
        exit 1
    fi
    
    # 构建并启动
    echo -e "${YELLOW}正在构建并启动容器...${NC}"
    if docker-compose up --build -d; then
        echo -e "${GREEN}✓ 博客已启动！${NC}"
        echo -e "${GREEN}访问地址: http://localhost:4000${NC}"
        echo -e "${YELLOW}查看日志: docker-compose logs -f${NC}"
        echo -e "${YELLOW}停止服务: docker-compose down${NC}"
    else
        echo -e "${RED}✗ 启动失败${NC}"
        echo -e "${YELLOW}查看详细错误信息: docker-compose logs${NC}"
        exit 1
    fi

elif [ "$MODE" = "local" ]; then
    echo -e "${YELLOW}使用本地 Ruby 方式启动...${NC}"
    
    # 检查 Ruby 和 Bundler
    if ! command -v ruby &> /dev/null; then
        echo -e "${RED}错误: 未找到 Ruby，请先安装 Ruby${NC}"
        echo -e "${YELLOW}建议: 使用 Homebrew 安装: brew install ruby${NC}"
        exit 1
    fi
    
    # 检查 Ruby 版本（需要 >= 3.0）
    RUBY_VERSION_FULL=$(ruby --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
    RUBY_VERSION_MAJOR=$(echo "$RUBY_VERSION_FULL" | cut -d. -f1)
    RUBY_VERSION_MINOR=$(echo "$RUBY_VERSION_FULL" | cut -d. -f2)
    
    if [ "$RUBY_VERSION_MAJOR" -lt 3 ]; then
        echo -e "${RED}错误: Ruby 版本过低 (当前: $RUBY_VERSION_FULL)${NC}"
        echo -e "${YELLOW}项目需要 Ruby >= 3.0.0${NC}"
        echo -e "${YELLOW}建议解决方案:${NC}"
        echo -e "  1. 使用 Docker 方式: ./start.sh docker (推荐)"
        echo -e "  2. 安装 Homebrew Ruby: brew install ruby"
        echo -e "  3. 使用 rbenv 管理 Ruby 版本: rbenv install 3.2.0"
        exit 1
    fi
    
    # 添加用户 gem 目录到 PATH（如果存在）
    USER_GEM_PATH="$HOME/.gem/ruby/$(ruby -e 'puts RUBY_VERSION[/\d+\.\d+/]')/bin"
    if [ -d "$USER_GEM_PATH" ]; then
        export PATH="$USER_GEM_PATH:$PATH"
    fi
    
    # 检查 bundler 版本
    if command -v bundle &> /dev/null; then
        BUNDLER_VERSION=$(bundle --version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+' | head -1)
        echo -e "${GREEN}检测到 Bundler 版本: $BUNDLER_VERSION${NC}"
    else
        echo -e "${YELLOW}未找到 Bundler，尝试安装...${NC}"
        # 检测 Ruby 版本并安装兼容的 bundler
        RUBY_VERSION=$(ruby -e 'puts RUBY_VERSION[/\d+\.\d+/]')
        if [ "$(echo "$RUBY_VERSION < 3.0" | bc 2>/dev/null || echo 1)" = "1" ]; then
            # Ruby < 3.0，安装 bundler 2.4.22
            gem install bundler -v 2.4.22 --user-install 2>/dev/null
        else
            # Ruby >= 3.0，安装最新版本
            gem install bundler --user-install 2>/dev/null
        fi
        # 更新 PATH
        if [ -d "$USER_GEM_PATH" ]; then
            export PATH="$USER_GEM_PATH:$PATH"
        fi
    fi
    
    # 验证 bundler 是否可用
    if ! command -v bundle &> /dev/null; then
        echo -e "${RED}错误: 无法找到或安装 Bundler${NC}"
        echo -e "${YELLOW}建议: 使用 Docker 方式启动: ./start.sh docker${NC}"
        exit 1
    fi
    
    # 安装依赖
    echo -e "${YELLOW}检查并安装依赖...${NC}"
    if ! bundle install; then
        echo -e "${RED}错误: 依赖安装失败${NC}"
        echo -e "${YELLOW}建议解决方案:${NC}"
        echo -e "  1. 使用 Docker 方式: ./start.sh docker"
        echo -e "  2. 安装 Homebrew Ruby: brew install ruby"
        echo -e "  3. 使用 rbenv 管理 Ruby 版本"
        exit 1
    fi
    
    # 启动 Jekyll
    echo -e "${YELLOW}启动 Jekyll 服务器...${NC}"
    echo -e "${GREEN}博客将在 http://localhost:4000 启动${NC}"
    echo -e "${YELLOW}按 Ctrl+C 停止服务器${NC}"
    bundle exec jekyll serve -H localhost -w
    
else
    echo -e "${RED}错误: 未知的启动方式 '$MODE'${NC}"
    echo -e "${YELLOW}使用方法: ./start.sh [docker|local|auto]${NC}"
    echo -e "${YELLOW}  - docker: 使用 Docker 方式（需要 Docker Desktop 运行）${NC}"
    echo -e "${YELLOW}  - local:  使用本地 Ruby 方式（需要 Ruby >= 3.0）${NC}"
    echo -e "${YELLOW}  - auto:   自动选择可用方式（默认）${NC}"
    exit 1
fi

