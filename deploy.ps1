# PhotoCraft 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/storytold/photocraft#downloads
# 更新日期：2026-10-26
# 类型：binary
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) { throw '需要先安装 curl（Windows 10+ 自带 curl.exe）' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

curl.exe -L --fail -o PhotoCraft.zip https://github.com/storytold/photocraft/releases/download/v0.16.0/photocraft-0.16.0-windows-x64-portable.zip
$h = (Get-FileHash -Algorithm SHA256 PhotoCraft.zip).Hash.ToLower() ; if ($h -ne '3e634f7e3cc95476c369d59ef0cfed3d1dd6fafd3c351ad81a4ddf3bd792e99d') { throw "SHA256 校验失败，文件可能不完整，请重试" }
Expand-Archive -Path PhotoCraft.zip -DestinationPath PhotoCraft -Force ; Write-Host '已解压到 PhotoCraft 目录，双击其中的 exe 启动'

Write-Host ''

Write-Host '安装完成：进入 PhotoCraft 目录双击可执行文件启动；macOS 拖进 Applications，Linux 直接运行 AppImage'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/storytold/photocraft#downloads'
