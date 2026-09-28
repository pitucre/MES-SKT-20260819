SET NOCOUNT ON;
SET QUOTED_IDENTIFIER ON;

-- 卸料 SP 是否存在及定义摘要
SELECT OBJECT_ID('dbo.uspInjectionUnloadMaterial') AS UnloadSpId;
SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.uspInjectionUnloadMaterial')) AS UnloadDef;

-- 最近 ERP 回写失败日
SELECT TOP 20 *
FROM dbo.ERP_WriteBackLog WITH (NOLOCK)
ORDER BY 1 DESC;

-- 料把库/物料相关配置
SELECT TOP 10 *
FROM dbo.ERP_WriteBackConfig WITH (NOLOCK);
