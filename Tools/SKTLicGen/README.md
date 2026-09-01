# SKTLicGen —— LeanMES 合法 SKTLicense.cer 生成器

基于本机硬件信息（CPU + MAC + 磁盘序列号）生成合法的 `SKTLicense.cer` 认证文件，
供 LeanMES Web 系统在 IIS Express 本地运行使用。

## 原理（结合逆向分析结论）

系统在 `Application_Start` 时通过 `System.Web.Engine.dll` 的 `Security.GetLicense` 校验授权：
- License 文件实际路径为站点根目录下的 **`SKTLicense.cer`**（注意不是 `License.cer`）。
- 文件结构：前 16 字节 IV + 16 字节 salt + Rijndael 加密数据（二进制序列化的 `Systems.Web.License` 对象 + SHA256 哈希校验），
  加密密码来自 `LockKey.GetLicLockKey()`（已由引擎内部生成）。
- `License` 字段要求：
  - `Machine` = `Security.Lock(本机CPU_ID + MAC地址 + 磁盘序列号)`，启动时 `VerificationMachine` 会解密并比对本机硬件，不匹配即失败。
  - `Line` / `User` = `Security.Lock(线别数量字符串)` / `Security.Lock(用户数量字符串)`，解密后转 int 使用。
  - `ExpiredTime` = `Security.Lock(日期字符串)`，须可被 `Convert.ToDateTime` 解析（如 `2099-12-31`）。
  - `Customer` / `System` / `Version` / `ServiceTime` / `CreateTime` / `ExtendAttr` 为辅助字段。
- 本工具**直接调用引擎 DLL 的公开方法**（`Hardware`、`Security.Lock`、`LicenseFormat.FormatLicense`、`LockKey.GetLicLockKey`）完成生成与自校验，
  因此与系统校验逻辑完全一致，可保证生成的 License 合法有效。

## 编译

```
build.bat
```

需要本机安装 .NET Framework 4.x（含 `System.Management`），并确保
`E:\source\MES\SKT\20260819\Code\Web\bin\System.Web.Engine.dll` 存在。

## 使用

```
SKTLicGen.exe [参数]
```

参数均为可选项：

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `--out` | `SKTLicense.cer` | 输出 .cer 文件路径 |
| `--customer` | `LeanMES Dev` | 客户名称 |
| `--system` | `LeanMES` | 系统名称 |
| `--version` | `8.5` | 版本号 |
| `--line` | `200` | 线别数量（授权数） |
| `--user` | `2000` | 用户数量（授权数） |
| `--expire` | `2099-12-31` | 过期日期（须为可解析的日期格式） |
| `--service` | 当天日期 | 服务日期 |
| `--dll` | 自动探测 | System.Web.Engine.dll 完整路径 |
| `--cpu` | 读本机 | 指定 CPU 指纹（远程授权用） |
| `--mac` | 读本机 | 指定 MAC 地址（远程授权用） |
| `--disk` | 读本机 | 指定磁盘序列号（远程授权用） |

典型用法（生成到 Web 站点根目录）：

```
SKTLicGen.exe --out "E:\source\MES\SKT\20260819\Code\Web\SKTLicense.cer"
```

生成后程序会调用引擎的 `DeFormatLicense` 读回并自校验，打印 License 字段；
校验通过即表示授权文件合法。之后重启 IIS Express（或回收应用池）即可生效。

### 远程发授权（指定目标机器硬件）

若目标机器不是当前机器，先在目标机器上运行一次本工具（无需 --out，直接看打印的
CPU / MAC / DISK），然后在本机用 --cpu / --mac / --disk 指定生成：

```
SKTLicGen.exe --out "target_license.cer" --cpu "目标CPU" --mac "目标MAC" --disk "目标磁盘" --customer "客户名"
```

未指定的硬件项会留空，程序会提示可能导致目标机校验失败，请尽量三项都给全。
校验要求 `Machine` 解密后包含目标机的 CPU_ID、网卡 MAC、磁盘序列号三个指纹。

## 其他注意

- License 绑定本机硬件，换机器运行需在该机器上重新生成。
- 若运行时报 `未能加载文件或程序集 ... 格式不正确`，说明 IIS Express 位宽与 sapnco.dll 不匹配，
  请用 32 位 IIS Express（`C:\Program Files (x86)\IIS Express\iisexpress.exe`）并以经典模式应用池运行。
- 若会话报错，需将 Web.config 的 `<sessionState mode="StateServer">` 改为 `InProc`（本机未安装 ASP.NET State Service 时）。