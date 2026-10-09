# AGENTS.md

## 备份规则（强制）

修改任何**原有**对象前，必须先自动备份，再执行修改：

- 存储过程（Stored Procedure）
- 函数（Function）
- 作业（SQL Server Job）

要求：

1. 修改前先导出当前完整定义（`OBJECT_DEFINITION` / job 定义）到带时间戳的备份文件。
2. 备份命名建议：`bak_<对象名>_<yyyyMMddHHmmss>.sql`。
3. 备份成功后再应用变更；禁止先改后补备份。
4. 新建对象（首次创建）可不强制备份，但若覆盖同名已有对象则必须备份。
5. 备份文件与修改脚本放在同一归档目录，便于回滚。

## 新对象命名规则（强制）

每次新需求开发时**新增**的数据库对象（存储过程、视图、函数、作业、表等），名称一律以 `_Program` 结尾，例如 `uspXXX_Program`、`vwXXX_Program`、`fnXXX_Program`。

- 仅数据库对象加后缀；报表的菜单显示名（中文名/英文名）**不加**。
- 已有对象改名不适用本规则（改名属于修改，须先备份）。

## 推送规则（用户说“推送”即执行）

用户发出“推送 / 提交并推送 / push”等指令时，直接按下面方式推送，无需再确认。默认同时推 GitHub 与 TFVC（TFS）。

### GitHub

- remote：`origin https://github.com/pitucre/MES-SKT-20260819.git`，分支 `main`。
- 提交信息用中文，多主题用 ` + ` 分隔；提交前 `git status` / `git diff`，**只 stage 本次任务相关文件**。
- 推送需走本地代理：`git -c http.proxy=http://127.0.0.1:7890 push origin main`（代理不通时等几秒重试）。

### TFVC（TFS）

- 集合：`http://192.168.2.100:8080/tfs/ProdConnection`；登录：`/login:xm.song,Sktxm@2024`（账号无域前缀）。
- `tf.exe`：`C:\Program Files\Microsoft Visual Studio\18\Community\Common7\IDE\CommonExtensions\Microsoft\TeamFoundation\Team Explorer\TF.exe`。
- 工作区 `LBJ` 映射：`$/LeanMES_8_5_7_SDYC` → `E:\source\MES\SKT\20260819`（即本仓库目录），在本目录下执行 tf 命令即可。
- 流程：
  1. `tf status <文件> /login:xm.song,Sktxm@2024 /noprompt` 查看状态（`/collection` 对 status/checkin 不识别，勿加）。
  2. 新文件是“检出到的更改/候选添加”时，先 `tf add <文件>` 再签入。
  3. `tf checkin <文件列表> /comment:"中文说明" /noprompt /login:xm.song,Sktxm@2024`。
- **只签入本次任务相关文件**；工作区存在大量他人 pending/检出到的更改，严禁整目录 checkin，也不要签入他人未完成的文件（如 csproj 中别人新增的引用项要先确认其源文件是否已入 TFS，避免编译缺文件）。
