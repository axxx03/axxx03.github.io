# 📖 博客启动快速指南

## 一键启动

```bash
cd /Users/rongwei/Note/academicpages.github.io
./start.sh
```

**注意**: 如果使用 Docker 方式，请先确保 Docker Desktop 已启动！

## 访问地址

启动成功后访问：**http://localhost:4000**

## 常用命令

| 操作 | 命令 |
|------|------|
| 启动博客 | `./start.sh` 或 `./start.sh docker` |
| 检查状态 | `./check.sh` |
| 查看日志 | `docker-compose logs -f` |
| 停止博客 | `docker-compose down` |

## 注意事项

- ✅ **推荐使用 Docker 方式**：系统 Ruby 版本为 2.6.10，项目需要 Ruby >= 3.0
- ✅ Docker 会自动处理所有依赖和环境问题
- ✅ 首次启动需要构建镜像，可能需要几分钟
- ✅ 后续启动会很快（使用缓存）

## 故障排查

如果启动失败，运行检查脚本：
```bash
./check.sh
```

查看详细日志：
```bash
docker-compose logs
```

