-- =====================================================================
-- 配置补齐：注塑不良品标签（TypeId = -39 注塑碎料单号）对应的标签文档
-- 背景：
--   1) 2026-09-21 提交 1907c5ee 将 注塑批次打印页（InjectionMoldingBatchPrintCollection.aspx）
--      的 UpdateList() 打印类型由 labelType=-36 改为 labelType=-39。
--   2) dbo.Basal_ItemDocuments 一直缺少 TypeId=-39 的映射，
--      导致 uspProdGetLableDocumentId 抛出：
--      "该注塑碎料单号还没维护对应的产品标签,请在标签管理进行维护"
--      -> 不良登记成功但标签未打印。
--   3) 正式库 172.16.5.144/LeanMes 与测试库 172.16.5.179/PROD_TEST_MES
--      已于 2026-09-26 14:09 手工补齐；本脚本用于环境一致性/发布留档，可重复执行。
--
-- 说明：正式库与测试库的 LabelDocumentId 不同（正式 11 / 测试 10），故按文档名解析。
-- 回滚：见文件末尾注释
-- =====================================================================
SET NOCOUNT ON;
GO

DECLARE @DocId INT;
DECLARE @Msg NVARCHAR(200);

SELECT @DocId = LabelDocumentId
FROM dbo.Basal_LabelDocument
WHERE DocumentName = N'碎料标签' AND Status = 'Enabled';

IF @DocId IS NULL
BEGIN
    SET @Msg = N'未找到启用的"碎料标签"文档，无法配置 TypeId=-39';
    RAISERROR(@Msg, 16, 1);
    RETURN;
END

IF NOT EXISTS (SELECT 1 FROM dbo.Basal_ItemDocuments
               WHERE ItemID = -1 AND TypeId = -39 AND StationId = -1)
BEGIN
    INSERT INTO dbo.Basal_ItemDocuments
        (ItemID, DocID, CreateBy, CreateDateTime, StationId, TypeId, Sequence, ModifyBy, ModifyDateTime, PrintSort)
    VALUES
        (-1, @DocId, 'admin', GETDATE(), -1, -39, 1, 'admin', GETDATE(), 0);

    PRINT N'已插入 TypeId=-39 -> DocID=' + CAST(@DocId AS NVARCHAR(10));
END
ELSE
BEGIN
    PRINT N'TypeId=-39 映射已存在，跳过（当前 DocID=' +
          CAST((SELECT DocID FROM dbo.Basal_ItemDocuments
                WHERE ItemID = -1 AND TypeId = -39 AND StationId = -1) AS NVARCHAR(10)) + N'）';
END
GO

-- 校验：应返回 1 行且不再抛错
-- EXEC dbo.uspProdGetLableDocumentId @ItemId=-1, @StationId=-1, @TypeId=-39, @Sequence=1;
GO

-- ---------------------------------------------------------------------
-- 回滚（仅在需要撤销时执行）：
-- DELETE FROM dbo.Basal_ItemDocuments
--  WHERE ItemID = -1 AND TypeId = -39 AND StationId = -1;
-- 备份：bak_Basal_ItemDocuments_nglabel_20260926143850.sql
-- ---------------------------------------------------------------------
