param()
$ErrorActionPreference = 'Stop'
$srcDir = "$PSScriptRoot\from_179"
$outFile = "$PSScriptRoot\Migration_to_144_LeanMes.sql"
$ts = Get-Date -Format 'yyyy-MM-dd'
$gbk = [System.Text.Encoding]::GetEncoding(936)

$preamble = @"
/*
===============================================================================
  Migration Script: 盘点功能 -> 172.16.5.144 / LeanMes (正式系统)
  Source: 172.16.5.179 / PROD_TEST_MES (测试系统)
  Date:   $ts

  变更内容:
    1. Prod_WarehouseCheckOrderDtl 添加 RealBarCode 列
    2. 配置 911 (盘点移库处理方式)
    3. 单号规则 -25 (调拨单号 Tra%YEAR%%MONTH%)
    4. 12 个存储过程 (9个已有重建 + 3个新建)

  备份: DataSql\bak_144_migration\ (执行前已导出144现有定义)
  来源: DataSql\from_179\ (从179导出的SP定义)

  执行: sqlcmd -S 172.16.5.144 -U sa -P SAsa123 -d LeanMes -b -i Migration_to_144_LeanMes.sql
===============================================================================
*/

USE LeanMes;
GO

-- ============================================================================
-- SECTION 0: PRE-FLIGHT CHECKS
-- ============================================================================

PRINT '==========================================';
PRINT 'PRE-FLIGHT: Verifying database connection';
PRINT '==========================================';

IF DB_NAME() <> 'LeanMes'
BEGIN
    RAISERROR('Wrong database! Must run against LeanMes on 144.', 16, 1);
    RETURN;
END

PRINT 'Database: ' + DB_NAME();

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=OBJECT_ID('Prod_WarehouseCheckOrderDtl') AND name='RealBarCode')
    PRINT 'RealBarCode column: EXISTS (will skip)'
ELSE
    PRINT 'RealBarCode column: MISSING (will add)';

IF EXISTS (SELECT 1 FROM Prod_MaterialSysConfig WHERE ConfigTypeId=911)
    PRINT 'Config 911: EXISTS (will update)'
ELSE
    PRINT 'Config 911: MISSING (will insert)';

IF EXISTS (SELECT 1 FROM Basal_SerialNumber WHERE Next_Number_Type=-25)
    PRINT 'SerialNumber -25: EXISTS (will skip)'
ELSE
    PRINT 'SerialNumber -25: MISSING (will insert)';

PRINT 'Pre-flight complete.';
GO

-- ============================================================================
-- SECTION 1: ADD COLUMN - RealBarCode
-- ============================================================================

PRINT 'SECTION 1: Adding RealBarCode column';

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=OBJECT_ID('Prod_WarehouseCheckOrderDtl') AND name='RealBarCode')
BEGIN
    ALTER TABLE Prod_WarehouseCheckOrderDtl ADD RealBarCode varchar(50) NULL;
    PRINT '  -> RealBarCode added.';
END
ELSE
    PRINT '  -> RealBarCode already exists. Skipping.';
GO

-- ============================================================================
-- SECTION 2: CONFIG 911 (盘点移库处理方式)
-- ============================================================================

PRINT 'SECTION 2: Config 911';

IF NOT EXISTS (SELECT 1 FROM Prod_MaterialSysConfig WHERE ConfigTypeId=911)
BEGIN
    INSERT INTO Prod_MaterialSysConfig (ConfigTypeId, ConfigDesc, ConfigResult, Remark)
    VALUES (911, '1-当场移库(同仓)/记录(跨仓) 2-只记录', '2',
            '盘点时实际库位与系统库位不一致的处理方式:1-当场执行移库/记录(仅同仓当场执行,跨仓记录差异);2-只记录实际库位到盘点明细,平帐时统一处理(同仓移库/跨仓调拨入库)');
    PRINT '  -> Config 911 inserted with value 2.';
END
ELSE
BEGIN
    UPDATE Prod_MaterialSysConfig
    SET ConfigDesc='1-当场移库(同仓)/记录(跨仓) 2-只记录',
        Remark='盘点时实际库位与系统库位不一致的处理方式:1-当场执行移库/记录(仅同仓当场执行,跨仓记录差异);2-只记录实际库位到盘点明细,平帐时统一处理(同仓移库/跨仓调拨入库)'
    WHERE ConfigTypeId=911;
    PRINT '  -> Config 911 already exists. Updated description.';
END
GO

-- ============================================================================
-- SECTION 3: SERIAL NUMBER RULE -25 (调拨单号)
-- ============================================================================

PRINT 'SECTION 3: SerialNumber rule -25';

IF NOT EXISTS (SELECT 1 FROM Basal_SerialNumber WHERE Next_Number_Type=-25)
BEGIN
    INSERT INTO Basal_SerialNumber (Next_Number_Type, Apply_Type, Type_Value, Revision, Prefix, Suffix, Description)
    VALUES (-25, 1, 'ALL', NULL, 'Tra%YEAR%%MONTH%', '', '盘点平帐调拨入库单号');
    PRINT '  -> SerialNumber -25 inserted.';
END
ELSE
    PRINT '  -> SerialNumber -25 already exists. Skipping.';
GO

-- ============================================================================
-- SECTION 4: STORED PROCEDURES (12 SPs copied from 179)
-- ============================================================================

PRINT 'SECTION 4: Applying Stored Procedures';

"@

$spList = @(
    "uspSaveCheckOrder",
    "uspWarehouseCheckCancel",
    "uspWarehouseCheckCancelCheck",
    "uspWarehouseCheckBatch",
    "uspGetWhMaterial",
    "uspWarehouseCheckDifferenceList",
    "uspGetCheckOrderDetail",
    "uspWarehouseCheckGetMaList",
    "uspStorageTransfer",
    "uspWarehouseCheckHandleLocationDiff_Program",
    "uspWarehouseCheckTransferIn_Program",
    "uspWarehouseCheckMoveMaterial_Program"
)

$body = New-Object System.Text.StringBuilder
[void]$body.AppendLine($preamble)

$missing = @()
foreach ($sp in $spList) {
    $srcFile = Join-Path $srcDir "$sp.sql"
    if (-not (Test-Path $srcFile)) { $missing += $sp; continue }
    $content = [System.IO.File]::ReadAllText($srcFile, $gbk)
    [void]$body.AppendLine("-- ============================================================")
    [void]$body.AppendLine("-- SP: $sp")
    [void]$body.AppendLine("-- ============================================================")
    [void]$body.AppendLine($content)
}
if ($missing.Count -gt 0) {
    Write-Host "ERROR: missing source files: $($missing -join ', ')" -ForegroundColor Red
    exit 1
}

$verification = @"

-- ============================================================================
-- SECTION 5: POST-MIGRATION VERIFICATION
-- ============================================================================

PRINT '==========================================';
PRINT 'POST-MIGRATION VERIFICATION';
PRINT '==========================================';

DECLARE @results TABLE (Obj VARCHAR(100), Status VARCHAR(20));

INSERT INTO @results VALUES ('RealBarCode column',
    CASE WHEN EXISTS(SELECT 1 FROM sys.columns WHERE object_id=OBJECT_ID('Prod_WarehouseCheckOrderDtl') AND name='RealBarCode')
    THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('Config 911',
    CASE WHEN EXISTS(SELECT 1 FROM Prod_MaterialSysConfig WHERE ConfigTypeId=911) THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('SerialNumber -25',
    CASE WHEN EXISTS(SELECT 1 FROM Basal_SerialNumber WHERE Next_Number_Type=-25) THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspSaveCheckOrder',
    CASE WHEN OBJECT_ID('uspSaveCheckOrder','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspWarehouseCheckCancel',
    CASE WHEN OBJECT_ID('uspWarehouseCheckCancel','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspWarehouseCheckCancelCheck',
    CASE WHEN OBJECT_ID('uspWarehouseCheckCancelCheck','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspWarehouseCheckBatch',
    CASE WHEN OBJECT_ID('uspWarehouseCheckBatch','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspGetWhMaterial',
    CASE WHEN OBJECT_ID('uspGetWhMaterial','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspWarehouseCheckDifferenceList',
    CASE WHEN OBJECT_ID('uspWarehouseCheckDifferenceList','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspGetCheckOrderDetail',
    CASE WHEN OBJECT_ID('uspGetCheckOrderDetail','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspWarehouseCheckGetMaList',
    CASE WHEN OBJECT_ID('uspWarehouseCheckGetMaList','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspStorageTransfer',
    CASE WHEN OBJECT_ID('uspStorageTransfer','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspWHCheckHandleLocDiff_Prog',
    CASE WHEN OBJECT_ID('uspWarehouseCheckHandleLocationDiff_Program','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspWHCheckTransferIn_Prog',
    CASE WHEN OBJECT_ID('uspWarehouseCheckTransferIn_Program','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspWHCheckMoveMaterial_Prog',
    CASE WHEN OBJECT_ID('uspWarehouseCheckMoveMaterial_Program','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);

SELECT * FROM @results;

DECLARE @failCount INT = (SELECT COUNT(*) FROM @results WHERE Status='FAIL');
IF @failCount > 0
    PRINT 'MIGRATION FAILED: ' + CAST(@failCount AS VARCHAR) + ' checks failed!';
ELSE
    PRINT 'MIGRATION COMPLETE: All checks passed!';
GO
"@

[void]$body.AppendLine($verification)

# Write as GBK (codepage 936) for sqlcmd 110 compatibility
[System.IO.File]::WriteAllText($outFile, $body.ToString(), $gbk)

# Verify
$check = [System.IO.File]::ReadAllText($outFile, $gbk)
$fail = $false
if (-not $check.Contains('存储过程')) { Write-Host 'FAIL: Chinese preamble corrupted' -ForegroundColor Red; $fail = $true }
if (-not $check.Contains('盘点')) { Write-Host 'FAIL: Chinese not found' -ForegroundColor Red; $fail = $true }
$dropCount = ([regex]::Matches($check, 'DROP PROCEDURE')).Count
$createCount = ([regex]::Matches($check, 'CREATE PROC')).Count
if ($dropCount -ne 12) { Write-Host "FAIL: DROP count=$dropCount (want 12)" -ForegroundColor Red; $fail = $true }
if ($createCount -lt 12) { Write-Host "FAIL: CREATE PROC count=$createCount (want >=12)" -ForegroundColor Red; $fail = $true }

Write-Host "Output: $outFile ($((Get-Item $outFile).Length) bytes)"
Write-Host "DROP=$dropCount CREATE=$createCount"
if (-not $fail) { Write-Host 'Generation OK' -ForegroundColor Green }
