/**
 * 粉碎机上料 5 场景复验
 * Env: 172.16.5.179 PROD_TEST_MES
 * 机台: SL01
 * 注意：测试会写入 Prod_SrapFeeding/Dtl，结束后由 cleanup 段删除
 */
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @Crusher VARCHAR(20) = 'SL01';
DECLARE @Msg NVARCHAR(500);
DECLARE @Pass INT = 0, @Fail INT = 0;

/* ========== 0. 清理：关掉 SL01/SL02 未完成上料，避免串单 ========== */
PRINT '=== 0. 清理未完成上料 ===';
DELETE d FROM dbo.Prod_SrapFeedingDtl d
INNER JOIN dbo.Prod_SrapFeeding h ON d.SrapFeedingId = h.SrapFeedingId
WHERE h.EquipmentCode IN ('SL01','SL02') AND h.Staues = 0;
DELETE h FROM dbo.Prod_SrapFeeding h
WHERE h.EquipmentCode IN ('SL01','SL02') AND h.Staues = 0;
PRINT 'cleaned open feedings';

/* ========== 1. 场景4：单候选 GRN 直接上料 ========== */
PRINT '';
PRINT '=== S4. 单候选 GRN（首扫直接上料） ===';
BEGIN TRY
    EXEC dbo.uspFeedingHopperLoadCrusher @CrusherCode=@Crusher, @BarCode='GRN260319000003', @CreateBy='sa', @SelectedMaterial='0303-00004';
    SET @Pass += 1;
    PRINT 'S4-1 PASS GRN260319000003 -> 0303-00004';
END TRY BEGIN CATCH
    SET @Fail += 1;
    PRINT 'S4-1 FAIL: ' + ERROR_MESSAGE();
END CATCH

BEGIN TRY
    EXEC dbo.uspFeedingHopperLoadCrusher @CrusherCode=@Crusher, @BarCode='GRN260319000004', @CreateBy='sa', @SelectedMaterial='0303-00004';
    SET @Pass += 1;
    PRINT 'S4-2 PASS 同料第二条 GRN260319000004';
END TRY BEGIN CATCH
    SET @Fail += 1;
    PRINT 'S4-2 FAIL: ' + ERROR_MESSAGE();
END CATCH

BEGIN TRY
    EXEC dbo.uspFeedingHopperLoadCrusher @CrusherCode=@Crusher, @BarCode='GRN260310000016', @CreateBy='sa', @SelectedMaterial='0303-00004';
    SET @Pass += 1;
    PRINT 'S4-3 PASS 同料第三条 GRN260310000016';
END TRY BEGIN CATCH
    SET @Fail += 1;
    PRINT 'S4-3 FAIL: ' + ERROR_MESSAGE();
END CATCH

/* ========== 2. 场景2：多个料把（同上，已在S4覆盖连扫）再验重复扫 ========== */
PRINT '';
PRINT '=== S2. 多料把连扫 + 重复扫拦截 ===';
BEGIN TRY
    EXEC dbo.uspFeedingHopperLoadCrusher @CrusherCode=@Crusher, @BarCode='GRN260319000003', @CreateBy='sa', @SelectedMaterial='0303-00004';
    SET @Fail += 1;
    PRINT 'S2-DUP FAIL 应拦截重复扫';
END TRY BEGIN CATCH
    SET @Pass += 1;
    PRINT 'S2-DUP PASS 重复扫已拦: ' + ERROR_MESSAGE();
END CATCH

/* ========== 3. 场景1：多个不良品标签（多候选需选料 + 连扫同料） ========== */
PRINT '';
PRINT '=== S1. 多个不良品标签 ===';
-- 多候选且未指定原料 → 应报请先选择
BEGIN TRY
    EXEC dbo.uspFeedingHopperLoadCrusher @CrusherCode=@Crusher, @BarCode='SNPC260319000002', @CreateBy='sa', @SelectedMaterial=NULL;
    SET @Fail += 1;
    PRINT 'S1-MULTI-NOPICK FAIL 应要求先选料';
END TRY BEGIN CATCH
    SET @Pass += 1;
    PRINT 'S1-MULTI-NOPICK PASS: ' + ERROR_MESSAGE();
END CATCH

-- 选本单已有原料 0303-00004 → 应成功
BEGIN TRY
    EXEC dbo.uspFeedingHopperLoadCrusher @CrusherCode=@Crusher, @BarCode='SNPC260319000002', @CreateBy='sa', @SelectedMaterial='0303-00004';
    SET @Pass += 1;
    PRINT 'S1-PICK PASS SNPC260319000002 选 0303-00004';
END TRY BEGIN CATCH
    SET @Fail += 1;
    PRINT 'S1-PICK FAIL: ' + ERROR_MESSAGE();
END CATCH

-- 第二个不良品：候选含本单原料 → 应成功（会话一致）
BEGIN TRY
    EXEC dbo.uspFeedingHopperLoadCrusher @CrusherCode=@Crusher, @BarCode='SNPC260319000003', @CreateBy='sa', @SelectedMaterial='0303-00004';
    SET @Pass += 1;
    PRINT 'S1-2ND PASS SNPC260319000003';
END TRY BEGIN CATCH
    SET @Fail += 1;
    PRINT 'S1-2ND FAIL: ' + ERROR_MESSAGE();
END CATCH

-- 第三个不良品：同料
BEGIN TRY
    EXEC dbo.uspFeedingHopperLoadCrusher @CrusherCode=@Crusher, @BarCode='SNPC260319000004', @CreateBy='sa', @SelectedMaterial='0303-00004';
    SET @Pass += 1;
    PRINT 'S1-3RD PASS SNPC260319000004';
END TRY BEGIN CATCH
    SET @Fail += 1;
    PRINT 'S1-3RD FAIL: ' + ERROR_MESSAGE();
END CATCH

-- 选错原料（不在候选/与本单不一致）
BEGIN TRY
    EXEC dbo.uspFeedingHopperLoadCrusher @CrusherCode=@Crusher, @BarCode='SNPC260319000005', @CreateBy='sa', @SelectedMaterial='0301-00018';
    SET @Fail += 1;
    PRINT 'S1-WRONG FAIL 应拦错料';
END TRY BEGIN CATCH
    SET @Pass += 1;
    PRINT 'S1-WRONG PASS: ' + ERROR_MESSAGE();
END CATCH

/* ========== 4. 场景3：1料把 + 1不良品 ========== */
PRINT '';
PRINT '=== S3. 料把+不良品混扫（同机台同原料） ===';
BEGIN TRY
    EXEC dbo.uspFeedingHopperLoadCrusher @CrusherCode=@Crusher, @BarCode='SNPC260319000006', @CreateBy='sa', @SelectedMaterial='0303-00004';
    SET @Pass += 1;
    PRINT 'S3-MIX PASS 不良品跟料把同原料 0303-00004';
END TRY BEGIN CATCH
    SET @Fail += 1;
    PRINT 'S3-MIX FAIL: ' + ERROR_MESSAGE();
END CATCH

/* ========== 5. 场景5：多候选人工选择（含跨原料拦截） ========== */
PRINT '';
PRINT '=== S5. 多候选人工选择 ===';
-- 不同原料料号的不良品（L1=0301-00018，候选不含0303-00004时前端应拒；SP用所选料校验）
BEGIN TRY
    EXEC dbo.uspFeedingHopperLoadCrusher @CrusherCode=@Crusher, @BarCode='SNPC260317000002', @CreateBy='sa', @SelectedMaterial='0303-00004';
    -- SNPC260317000002 候选是 0301-00018,0301-00017,0301-00067，不含 0303-00004 → 应报错
    SET @Fail += 1;
    PRINT 'S5-OTHER-MAT FAIL 应拦不同原料';
END TRY BEGIN CATCH
    SET @Pass += 1;
    PRINT 'S5-OTHER-MAT PASS: ' + ERROR_MESSAGE();
END CATCH

/* ========== 当前单状态 ========== */
PRINT '';
PRINT '=== 当前 SL01 未完成单明细 ===';
SELECT h.SrapFeedingNo, h.EquipmentCode, h.Staues, h.MaterialPartNumberCode,
       d.BarCode, d.BarCodeItemCode, d.BarcodeQty
FROM dbo.Prod_SrapFeeding h WITH(NOLOCK)
LEFT JOIN dbo.Prod_SrapFeedingDtl d WITH(NOLOCK) ON d.SrapFeedingId = h.SrapFeedingId
WHERE h.EquipmentCode = @Crusher AND h.Staues = 0
ORDER BY d.SrapFeedingDtId;

PRINT '';
PRINT 'RESULT Pass=' + CAST(@Pass AS VARCHAR(10)) + ' Fail=' + CAST(@Fail AS VARCHAR(10));

/* ========== 清理测试数据 ========== */
PRINT '';
PRINT '=== cleanup test data ===';
DELETE d FROM dbo.Prod_SrapFeedingDtl d
INNER JOIN dbo.Prod_SrapFeeding h ON d.SrapFeedingId = h.SrapFeedingId
WHERE h.EquipmentCode = @Crusher AND h.Staues = 0 AND h.CreateBy = 'sa';
DELETE h FROM dbo.Prod_SrapFeeding h
WHERE h.EquipmentCode = @Crusher AND h.Staues = 0 AND h.CreateBy = 'sa';
PRINT 'cleanup done';
