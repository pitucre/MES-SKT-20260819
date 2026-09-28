# ASCII only. Fix duplicate @EquiCode in DualWrite179 blocks on 144.
$ErrorActionPreference = 'Stop'
$outDir = 'C:\Users\Administrator\AppData\Local\Temp\opencode'
$cs144 = 'server=172.16.5.144;uid=sa;pwd=SAsa123;database=LeanMes;Connect Timeout=120'
$stamp = Get-Date -Format 'yyyyMMddHHmmss'
$log = @()

$targets = @(
  @{
    Name = 'uspEquimentCollection'
    Exec = 'EXEC [172.16.5.179].[PROD_TEST_MES].dbo.[uspEquimentCollection] @ParamterStr = @ParamterStr, @ParamterVal = @ParamterVal, @EquipmentType = @EquipmentType, @EquiCode = @EquiCode;'
  },
  @{
    Name = 'uspEquimentCollection_250908'
    Exec = 'EXEC [172.16.5.179].[PROD_TEST_MES].dbo.[uspEquimentCollection_250908] @ParamterStr = @ParamterStr, @ParamterVal = @ParamterVal, @EquipmentType = @EquipmentType, @EquiCode = @EquiCode;'
  },
  @{
    Name = 'uspEquimentCollectionHMG'
    Exec = 'EXEC [172.16.5.179].[PROD_TEST_MES].dbo.[uspEquimentCollectionHMG] @ParamterJSONVal = @ParamterJSONVal, @EquiCode = @EquiCode;'
  },
  @{
    Name = 'uspEquimentCollectionHT'
    Exec = 'EXEC [172.16.5.179].[PROD_TEST_MES].dbo.[uspEquimentCollectionHT] @Status = @Status, @EquiCode = @EquiCode, @ActCntPrt = @ActCntPrt;'
  }
)

$c = New-Object System.Data.SqlClient.SqlConnection($cs144)
$c.Open()

function Exec-Sql($conn, $sql) {
  $cmd = $conn.CreateCommand()
  $cmd.CommandText = $sql
  [void]$cmd.ExecuteNonQuery()
}

foreach ($t in $targets) {
  $name = $t.Name
  $cmd = $c.CreateCommand()
  $cmd.CommandText = "SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.' + @n))"
  [void]$cmd.Parameters.AddWithValue('@n', $name)
  $def = $cmd.ExecuteScalar()
  $cmd.Parameters.Clear()
  if (-not $def) { $log += "MISSING $name"; continue }

  $bak = Join-Path $outDir ("bak144fix_" + $name + "_$stamp.sql")
  [System.IO.File]::WriteAllText($bak, $def, [System.Text.UTF8Encoding]::new($false))

  # strip existing DualWrite block (from marker line through end marker line inclusive)
  $stripped = [regex]::Replace($def, '(?ms)^[ \t]*-- DualWrite179 start.*?^[ \t]*-- DualWrite179 end[ \t]*\r?\n?', '')
  # also strip old malformed variants if any
  $stripped = [regex]::Replace($stripped, '(?ms)^[ \t]*; DualWrite179 start.*?^[ \t]*; DualWrite179 end[ \t]*\r?\n?', '')
  $stripped = [regex]::Replace($stripped, '(?ms)^[ \t]*-- DualWrite179 start.*?END CATCH[ \t]*\r?\n?[ \t]*-- DualWrite179 end[ \t]*\r?\n?', '')

  if ($stripped -match 'DualWrite179') {
    $log += "WARN residual marker $name"
    # force remove any line containing DualWrite179
    $lines = $stripped -split "`r?`n"
    $lines = $lines | Where-Object { $_ -notmatch 'DualWrite179' }
    $stripped = ($lines -join "`r`n")
  }

  $block = @"
    -- DualWrite179 start
    BEGIN TRY
        $($t.Exec)
    END TRY
    BEGIN CATCH
        PRINT 'DualWrite179_ERR ${name}: ' + ERROR_MESSAGE();
    END CATCH
    -- DualWrite179 end
"@

  $m = [regex]::Matches($stripped, '(?m)^[ \t]*END[ \t]*\r?$')
  if ($m.Count -eq 0) { $log += "ERR no final END $name"; continue }
  $last = $m[$m.Count - 1]
  $newDef = $stripped.Substring(0, $last.Index) + $block + "`r`n" + $stripped.Substring($last.Index)

  # sanity: no duplicate @EquiCode in same EXEC line
  foreach ($line in ($newDef -split "`r?`n")) {
    if ($line -match 'DualWrite|EXEC \[172\.16\.5\.179\]') {
      $eqCount = ([regex]::Matches($line, '@EquiCode\s*=')).Count
      if ($eqCount -gt 1) { $log += "ERR dup EquiCode still in line for $name"; }
    }
  }

  try {
    Exec-Sql $c "IF OBJECT_ID('dbo.[$name]','P') IS NOT NULL DROP PROCEDURE [dbo].[$name];"
    Exec-Sql $c $newDef
    $cmd.CommandText = "SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.' + @n))"
    [void]$cmd.Parameters.AddWithValue('@n', $name)
    $chk = $cmd.ExecuteScalar()
    $cmd.Parameters.Clear()
    $dup = $false
    foreach ($line in ($chk -split "`r?`n")) {
      if ($line -match 'EXEC \[172\.16\.5\.179\]') {
        if (([regex]::Matches($line, '@EquiCode\s*=')).Count -gt 1) { $dup = $true }
      }
    }
    if ($chk -and $chk -match 'DualWrite179 start' -and -not $dup) { $log += "FIXED $name" }
    else { $log += "VERIFY_FAIL $name dup=$dup hasDW=$([bool]($chk -match 'DualWrite179'))" }
  } catch {
    $log += "APPLY_ERR $name : $($_.Exception.Message)"
    try { Exec-Sql $c $def; $log += "RESTORED $name" }
    catch { $log += "RESTORE_FAIL $name : $($_.Exception.Message)" }
  }
}

$c.Close()
$text = $log -join "`r`n"
[System.IO.File]::WriteAllText((Join-Path $outDir 'dualwrite_fix_log.txt'), $text, [System.Text.UTF8Encoding]::new($false))
Write-Output 'OK'
Write-Output $text
