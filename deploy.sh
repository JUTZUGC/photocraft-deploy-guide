#!/usr/bin/env bash
set -euo pipefail
# PhotoCraft 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/storytold/photocraft#downloads
# 更新日期：2026-10-26
# 类型：binary
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v curl >/dev/null 2>&1 || { echo "需要先安装 curl"; exit 1; }

mkdir -p .download
cd .download

if [ "$(uname -s)" = "Darwin" ]; then curl -fL -o PhotoCraft.dmg https://github.com/storytold/photocraft/releases/download/v0.16.0/photocraft-0.16.0-macos-universal.dmg ; want=489e00a7fd19f7e924a3a05ec33c7b057ea4766129b4eef132ce82ff42c10619 ; file=PhotoCraft.dmg ; else curl -fL -o PhotoCraft.AppImage https://github.com/storytold/photocraft/releases/download/v0.16.0/photocraft-0.16.0-linux-x86_64.AppImage ; want=fc670139091e661e948a6de1ff2219a6dd04232e6ac8616349ee238a7a49d54e ; file=PhotoCraft.AppImage ; fi
if command -v sha256sum >/dev/null 2>&1; then echo "$want  $file" | sha256sum -c - ; else echo "$want  $file" | shasum -a 256 -c - ; fi
if [ "$(uname -s)" = "Linux" ]; then chmod +x PhotoCraft.AppImage ; echo "已就绪：./PhotoCraft.AppImage" ; else echo "已下载 PhotoCraft.dmg，双击挂载后拖进 Applications" ; fi

echo ""

echo "安装完成：进入 PhotoCraft 目录双击可执行文件启动；macOS 拖进 Applications，Linux 直接运行 AppImage"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/storytold/photocraft#downloads"
