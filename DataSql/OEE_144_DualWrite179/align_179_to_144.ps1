# ASCII only. Backup 179 M03 template+SP, then copy from 144 (exact same column names).
$ErrorActionPreference = 'Stop'
$outDir = 'C:\Users\Administrator\AppData\Local\Temp\opencode'
$dll = 'E:\source\MES\SKT\20260819\Code\Lib\SKT.Common.Utility.dll'
Add-Type -Path $dll
Add-Type -AssemblyName System.Web

$cs144 = 'server=172.16.5.144;uid=sa;pwd=SAsa123;database=LeanMes;Connect Timeout=60'
$cs179 = 'server=172.16.5.179;uid=sa;pwd=SAsa123;database=PROD_TEST_MES;Connect Timeout=60'
$guid = '615562BE-0600-48B0-B41E-720047121637'
$stamp = Get-Date -Format 'yyyyMMddHHmmss'

# --- fetch 144 template content (raw encrypted) + SP definition ---
$c144 = New-Object System.Data.SqlClient.SqlConnection($cs144)
$c144.Open()
$cmd = $c144.CreateCommand()
$cmd.CommandText = "SELECT TemplateContent FROM Report_Template WHERE TemplateName=@g"
[void]$cmd.Parameters.AddWithValue('@g', $guid)
$tpl144 = $cmd.ExecuteScalar()
$cmd.Parameters.Clear()
$cmd.CommandText = "SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.uspEquipmentOEEReport'))"
$sp144 = $cmd.ExecuteScalar()
$c144.Close()

if (-not $tpl144) { throw '144 template not found' }
if (-not $sp144) { throw '144 SP not found' }

# decrypt 144 for column check
$plain144 = [SKT.Common.Utility.EncryptHelper]::Decrypt($tpl144)
$html144 = [System.Web.HttpUtility]::UrlDecode($plain144)
[System.IO.File]::WriteAllText((Join-Path $outDir 'align_144_template.html'), $html144, [System.Text.UTF8Encoding]::new($false))
[System.IO.File]::WriteAllText((Join-Path $outDir 'align_144_sp.sql'), $sp144, [System.Text.UTF8Encoding]::new($false))

# --- backup 179 current ---
$c179 = New-Object System.Data.SqlClient.SqlConnection($cs179)
$c179.Open()
$cmd179 = $c179.CreateCommand()
$cmd179.CommandText = "SELECT TemplateContent FROM Report_Template WHERE TemplateName=@g"
[void]$cmd179.Parameters.AddWithValue('@g', $guid)
$tpl179 = $cmd179.ExecuteScalar()
$cmd179.Parameters.Clear()
$cmd179.CommandText = "SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.uspEquipmentOEEReport'))"
$sp179 = $cmd179.ExecuteScalar()
$c179.Close()

if ($tpl179) {
  [System.IO.File]::WriteAllText((Join-Path $outDir "bak_179_template_$stamp.enc.txt"), $tpl179, [System.Text.UTF8Encoding]::new($false))
  try {
    $p = [SKT.Common.Utility.EncryptHelper]::Decrypt($tpl179)
    $h = [System.Web.HttpUtility]::UrlDecode($p)
    [System.IO.File]::WriteAllText((Join-Path $outDir "bak_179_template_$stamp.html"), $h, [System.Text.UTF8Encoding]::new($false))
  } catch {}
}
if ($sp179) {
  [System.IO.File]::WriteAllText((Join-Path $outDir "bak_179_sp_$stamp.sql"), $sp179, [System.Text.UTF8Encoding]::new($false))
}

# --- write 179 template from 144 ciphertext ---
$c179 = New-Object System.Data.SqlClient.SqlConnection($cs179)
$c179.Open()
$tx = $c179.BeginTransaction()
try {
  $u = $c179.CreateCommand()
  $u.Transaction = $tx
  $u.CommandText = "UPDATE Report_Template SET TemplateContent=@c, ModifyDateTime=GETDATE(), ModifyBy='align144' WHERE TemplateName=@g"
  [void]$u.Parameters.AddWithValue('@c', $tpl144)
  [void]$u.Parameters.AddWithValue('@g', $guid)
  $n = $u.ExecuteNonQuery()
  $tx.Commit()
  Write-Output "TEMPLATE_UPDATED rows=$n"
} catch {
  $tx.Rollback()
  throw
} finally {
  $c179.Close()
}

# --- write SP: extract CREATE PROC from 144 def and run on 179 ---
# OBJECT_DEFINITION returns CREATE PROCEDURE ... ; without GO sometimes
$spBody = $sp144
if ($spBody -notmatch 'CREATE\s+PROCEDURE') { throw 'SP def missing CREATE PROCEDURE' }

# Build SQL file for sqlcmd
$spSqlPath = Join-Path $outDir 'align_179_sp_apply.sql'
$sql = @"
USE [PROD_TEST_MES];
GO
IF OBJECT_ID('dbo.uspEquipmentOEEReport','P') IS NOT NULL DROP PROCEDURE [dbo].[uspEquipmentOEEReport];
GO
$spBody
GO
"@
[System.IO.File]::WriteAllText($spSqlPath, $sql, [System.Text.UTF8Encoding]::new($false))
Write-Output "SP_SQL_WRITTEN $spSqlPath"
Write-Output "DONE_PREP"
