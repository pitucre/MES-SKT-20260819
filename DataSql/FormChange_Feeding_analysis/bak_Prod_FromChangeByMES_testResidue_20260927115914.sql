/**
 * Data backup: 测试残留形态转换单（用户批准删除前的完整备份）
 * Created: 20260927115914
 * Server: 172.16.5.179 / PROD_TEST_MES
 * Rows: Prod_FromChangeByMES 2 rows (Id 24 XT2609260001, Id 31 XT2609260012) + Prod_FromChangeByMESDt 3 rows (37/38/49)
 * Note : XT2609260007 已在会话外被删除，不在本次备份内
 * Restore: 取消下行 SET IDENTITY_INSERT 注释后执行
 */
SET NOCOUNT ON;
--SET IDENTITY_INSERT dbo.Prod_FromChangeByMES ON;
--INSERT INTO dbo.Prod_FromChangeByMES (FromChangeByMESId,FromChangeByMESNo,Staues,ERPNo,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime)
--VALUES (24,'XT2609260001',0,NULL,N'admin','2026-09-26 13:07:31.603',NULL,NULL);
--VALUES (31,'XT2609260012',0,NULL,N'admin','2026-09-26 19:22:45.780',NULL,NULL);
--SET IDENTITY_INSERT dbo.Prod_FromChangeByMES OFF;
--SET IDENTITY_INSERT dbo.Prod_FromChangeByMESDt ON;
--INSERT INTO dbo.Prod_FromChangeByMESDt (FromChangeByMESDtId,FromChangeByMESId,BarCode,PreConversionMaterial,ConvertedMaterial,ConvertedQty,cBarCode,CreateBy,CreateDateTime)
--VALUES (37,24,N'GRN260924000001','0201-00125','0601-00018',12.000000,NULL,N'admin','2026-09-26 13:07:31.603'),
--       (38,24,N'SL2609260001','0301-00018','0601-00018',16.000000,NULL,N'admin','2026-09-26 13:07:38.663'),
--       (49,31,N'SL2609260004','0301-00017','0601-00017',31.000000,NULL,N'admin','2026-09-26 19:22:45.780');
--SET IDENTITY_INSERT dbo.Prod_FromChangeByMESDt OFF;