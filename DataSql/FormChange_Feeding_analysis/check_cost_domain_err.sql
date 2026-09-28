SET NOCOUNT ON;
SET QUOTED_IDENTIFIER ON;

SELECT TOP 10
    WriteBackCode, ERPResult, ERPMsg, MESMsg, MESBillNo,
    CreateBy, CreateDateTime, ReceiveData
FROM dbo.ERP_WriteBackLog WITH (NOLOCK)
WHERE WriteBackCode = 'OtherWarehousing'
  AND (
        ISNULL(ERPMsg, '') LIKE N'%成本域%'
     OR ISNULL(ReceiveData, '') LIKE N'%成本域%'
     OR ISNULL(ERPMsg, '') LIKE N'%1503-00240%'
     OR ISNULL(ReceiveData, '') LIKE N'%1503-00240%'
     OR ISNULL(WriteBackData, '') LIKE N'%1503-00240%'
      )
ORDER BY CreateDateTime DESC;

SELECT WriteBackCode, WriteBackFlag
FROM dbo.ERP_WriteBackConfig WITH (NOLOCK)
WHERE WriteBackCode IN ('OtherWarehousing', 'FormChangeCheck', 'MaterialStorage', 'FinishStorage');
