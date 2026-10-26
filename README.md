# PhotoCraft 一键安装指南

> 第三方部署指南 · 非 PhotoCraft 官方仓库。官方项目：[storytold/photocraft](https://github.com/storytold/photocraft)
> 内容来自官方文档（2026-10-26）。项目迭代快，请以[官方文档](https://github.com/storytold/photocraft#downloads)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用自己找安装包，让百度搭子下载、校验、解压，打开就能改 PSD。

⚠️ 项目标注为 early alpha：能开 PSD、图层、蒙版、调整层，但别指望完全替代 Photoshop。Windows 用便携版 zip，macOS 是 dmg，Linux 是 AppImage，首次打开可能被系统拦。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/photocraft-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会按你的系统下载对应安装包、核对 SHA256，Windows 上还会自动解压好，按它的提示确认即可，结束时它会告诉你结果。
   （下载地址与校验方式以官方文档为准。）



## PhotoCraft 是什么？

PhotoCraft 是开源的纯 Rust 写的开源图像编辑器（可开 PSD）（协议：Apache-2.0，<img src="https://img.shields.io/github/stars/storytold/photocraft?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

纯 Rust 写的光栅图像编辑器：图层、蒙版、调整图层、文字、画笔，能打开和保存真实 PSD；所有操作都是命令，界面、CLI、JSON 控制通道和 MCP 走同一套引擎。

- 格式：打开 / 编辑 / 保存 PSD
- 功能：图层、蒙版、调整图层、文字、画笔
- 自动化：500+ 命令，UI / CLI / JSON / MCP 共用
- 平台：Windows / macOS / Linux / FreeBSD / Web
- 体积：Windows 便携包约 90 MB

（来源：[官方仓库](https://github.com/storytold/photocraft)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 73.1k stars | Apache-2.0 / MIT 双协议，更新频繁 |
| 能开真 PSD | 图层、蒙版、调整层、文字 |
| 纯 Rust | 体积小、启动快，不用装 Adobe |
| 跨平台 | Windows / macOS / Linux / FreeBSD / Web |
| 为 Agent 设计 | UI / CLI / JSON / MCP 共用一套命令 |

| 需要注意 | 说明 |
|---|---|
| early alpha | 复杂 PSD 与高级功能还不完整 |
| 没有中文界面说明 | 文档以英文为主 |
| 首次打开会被拦 | Windows SmartScreen / macOS 未签名提示 |
| 内存占用随图层增长 | 大文件编辑要留足内存 |
| 插件生态没有 | 拿不到 PS 的滤镜与插件 |

> 以上基于官方文档与社区反馈整理（2026-10-26），以官方最新文档为准。

## 官方安装方式（可手动执行）

```bash
if [ "$(uname -s)" = "Darwin" ]; then curl -fL -o PhotoCraft.dmg https://github.com/storytold/photocraft/releases/download/v0.16.0/photocraft-0.16.0-macos-universal.dmg ; want=489e00a7fd19f7e924a3a05ec33c7b057ea4766129b4eef132ce82ff42c10619 ; file=PhotoCraft.dmg ; else curl -fL -o PhotoCraft.AppImage https://github.com/storytold/photocraft/releases/download/v0.16.0/photocraft-0.16.0-linux-x86_64.AppImage ; want=fc670139091e661e948a6de1ff2219a6dd04232e6ac8616349ee238a7a49d54e ; file=PhotoCraft.AppImage ; fi
if command -v sha256sum >/dev/null 2>&1; then echo "$want  $file" | sha256sum -c - ; else echo "$want  $file" | shasum -a 256 -c - ; fi
if [ "$(uname -s)" = "Linux" ]; then chmod +x PhotoCraft.AppImage ; echo "已就绪：./PhotoCraft.AppImage" ; else echo "已下载 PhotoCraft.dmg，双击挂载后拖进 Applications" ; fi
```

安装包来源：[https://github.com/storytold/photocraft/releases/latest](https://github.com/storytold/photocraft/releases/latest)

## 验证状态

| 场景 | 状态 |
|---|---|
| Release v0.16.0 的 Windows / macOS / Linux 包与 SHA256 digest 已核对 | 已核对 2026-10-26 |
| 未下载安装（包体 83–99 MB，本机网络不适合完整拉取） | 已核对 2026-10-26 |
| MCP 服务握手与工具列表（initialize / tools/list） | 已验证 2026-10-26 |
| 非目标宿主调用被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-26 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

PhotoCraft 自带 MCP server 与 JSON 控制通道，Agent 能直接驱动同一套命令。本仓库的 MCP 只提供下载、校验与常见坑。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-26）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\photocraft-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装完成后

| 平台 | 包 | 用法 |
|---|---|---|
| Windows | `photocraft-0.16.0-windows-x64-portable.zip` | 解压后双击 exe |
| macOS | `photocraft-0.16.0-macos-universal.dmg` | 挂载后拖进 Applications |
| Linux | `photocraft-0.16.0-linux-x86_64.AppImage` | `chmod +x` 后直接运行 |

### 给 Agent 用

每次菜单操作背后都是命令，CLI 和 MCP 走同一套：

```bash
photocraft-cli batch --help
```

> 项目处于 early alpha：复杂 PSD 的混合模式、智能对象等可能还不完整，重要文件先备份原稿。

## 常见坑

- Windows 提示未知发布者：点「更多信息 → 仍要运行」
- macOS 提示无法验证开发者：到「隐私与安全性」点「仍要打开」
- Linux AppImage 打不开：先 `chmod +x`，缺 FUSE 时加 `--appimage-extract-and-run`
- PSD 打开后图层错位：先备份原稿，复杂混合模式可能还不支持
- 别拿它当唯一生产工具：alpha 阶段，重要项目保留 Photoshop / GIMP 兜底
- 命令行找不到：`photocraft-cli` 在 Release 的单独压缩包里

## 免责声明

本仓库为第三方指南，与 PhotoCraft 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-26），项目迭代快，请以[官方文档](https://github.com/storytold/photocraft#downloads)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
