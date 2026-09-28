# LeanMES 授权工具套件

## 工具说明

| 工具 | 用途 | 运行位置 |
|------|------|----------|
| **SKTHwCollector** | 收集目标电脑硬件信息 | 目标电脑（客户现场） |
| **SKTLicGen** | 生成授权证书 .cer | 开发商电脑 |

## 工作流程

```
目标电脑                        开发商电脑
┌─────────────────┐            ┌─────────────────────┐
│ SKTHwCollector  │            │    SKTLicGen        │
│                 │  hwinfo.txt│                     │
│ 收集 CPU+MAC+DISK│ ────────> │ 读取硬件信息        │
│ 生成 hwinfo.txt │            │ 生成 SKTLicense.cer │
└─────────────────┘            └─────────────────────┘
                                        │
                                        v
                               ┌─────────────────┐
                               │   IIS Web 站点   │
                               │  放入 .cer 文件  │
                               └─────────────────┘
```

## 快速开始

### 1. 在目标电脑上收集硬件信息

将 `SKTHwCollector.exe` 拷贝到目标电脑，双击运行：

```
SKTHwCollector.exe
```

- 自动生成 `hwinfo.txt` 文件
- 将 `hwinfo.txt` 发送给系统管理员

### 2. 在开发商电脑上生成授权证书

```
SKTLicGen.exe --hwinfo hwinfo.txt --out SKTLicense.cer --customer "客户名称"
```

- 将生成的 `SKTLicense.cer` 拷贝到目标电脑的 Web 站点根目录
- 重启 IIS 或回收应用池

## SKTHwCollector 参数

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `--out` | `hwinfo.txt` | 输出文件路径 |
| `--clip` | 否 | 同时复制命令行到剪贴板 |

## SKTLicGen 参数

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `--hwinfo` | 无 | 从 SKTHwCollector 生成的文件读取硬件信息 |
| `--cpu` | 读本机 | 指定 CPU 指纹（命令行方式） |
| `--mac` | 读本机 | 指定 MAC 地址（命令行方式） |
| `--disk` | 读本机 | 指定磁盘序列号（命令行方式） |
| `--out` | `SKTLicense.cer` | 输出文件路径 |
| `--customer` | `LeanMES Dev` | 客户名称 |
| `--system` | `LeanMES` | 系统名称 |
| `--version` | `8.5` | 版本号 |
| `--line` | `200` | 线别数量（授权数） |
| `--user` | `2000` | 用户数量（授权数） |
| `--expire` | `2099-12-31` | 过期日期 |
| `--service` | 当天日期 | 服务日期 |
| `--dll` | 自动探测 | System.Web.Engine.dll 路径 |

## 编译

```batch
# 编译硬件收集工具
cd Tools\SKTHwCollector
build.bat

# 编译证书生成工具
cd Tools\SKTLicGen
build.bat
```

## 依赖

- **SKTHwCollector**: 无外部依赖，仅需 .NET Framework 4.x
- **SKTLicGen**: 需要 `System.Web.Engine.dll`（来自 `Code\Web\bin\` 或 `Code\Lib\`）
