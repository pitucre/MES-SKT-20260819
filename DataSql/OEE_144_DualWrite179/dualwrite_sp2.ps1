# ASCII only. Dual-write 144 collection SPs to 179 with fixed signatures.
$ErrorActionPreference = 'Stop'
$outDir = 'C:\Users\Administrator\AppData\Local\Temp\opencode'
$cs144 = 'server=172.16.5.144;uid=sa;pwd=SAsa123;database=LeanMes;Connect Timeout=120'
$stamp = Get-Date -Format 'yyyyMMddHHmmss'
$log = @()

# Hardcoded signatures (verified from backups)
$targets = @(
  @{
    Name = 'uspEquimentCollection'
    Args = '@ParamterStr = @ParamterStr, @ParamterVal = @ParamterVal, @EquipmentType = @EquipmentType, @EquiCode = @EquiCode'
    OutVar = 'DECLARE @__dw_code VARCHAR(100) = ISNULL(@EquiCode, '''');'
    OutArg = ', @EquiCode = @__dw_code'
  },
  @{
    Name = 'uspEquimentCollection_250908'
    Args = '@ParamterStr = @ParamterStr, @ParamterVal = @ParamterVal, @EquipmentType = @EquipmentType, @EquiCode = @EquiCode'
    OutVar = 'DECLARE @__dw_code VARCHAR(100) = ISNULL(@EquiCode, '''');'
    OutArg = ', @EquiCode = @__dw_code'
  },
  @{
    Name = 'uspEquimentCollectionHMG'
    Args = '@ParamterJSONVal = @ParamterJSONVal'
    OutVar = 'DECLARE @__dw_code VARCHAR(100) = ISNULL(@EquiCode, '''');'
    OutArg = ', @EquiCode = @__dw_code'
  },
  @{
    Name = 'uspEquimentCollectionHT'
    Args = '@Status = @Status, @EquiCode = @EquiCode, @ActCntPrt = @ActCntPrt'
    OutVar = ''
    OutArg = ''
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

  if ($def -match 'DualWrite179 start') {
    $log += "ALREADY $name"
    continue
  }

  $bak = Join-Path $outDir ("bak144_" + $name + "_$stamp.sql")
  [System.IO.File]::WriteAllText($bak, $def, [System.Text.UTF8Encoding]::new($false))
  $log += "BACKUP $name len=$($def.Length)"

  $remoteArgs = $t.Args
  if ($t.OutArg) { $remoteArgs = $t.Args + $t.OutArg }

  $outVarLine = ''
  if ($t.OutVar) { $outVarLine = "    $($t.OutVar)`r`n" }

  $block = @"
    -- DualWrite179 start
$outVarLine    BEGIN TRY
        EXEC [172.16.5.179].[PROD_TEST_MES].dbo.[$name] $remoteArgs;
    END TRY
    BEGIN CATCH
        PRINT 'DualWrite179_ERR ${name}: ' + ERROR_MESSAGE();
    END CATCH
    -- DualWrite179 end
"@

  # Insert before the last procedure-level END (line that is only END)
  $m = [regex]::Matches($def, '(?m)^[ \t]*END[ \t]*\r?$')
  if ($m.Count -eq 0) { $log += "ERR no final END $name"; continue }
  $last = $m[$m.Count - 1]
  $newDef = $def.Substring(0, $last.Index) + $block + "`r`n" + $def.Substring($last.Index)

  $newPath = Join-Path $outDir ("new144_" + $name + ".sql")
  [System.IO.File]::WriteAllText($newPath, $newDef, [System.Text.UTF8Encoding]::new($false))

  try {
    Exec-Sql $c "IF OBJECT_ID('dbo.[$name]','P') IS NOT NULL DROP PROCEDURE [dbo].[$name];"
    Exec-Sql $c $newDef
    $cmd.CommandText = "SELECT OBJECT_DEFINITION(OBJECT_ID('dbo.' + @n))"
    [void]$cmd.Parameters.AddWithValue('@n', $name)
    $chk = $cmd.ExecuteScalar()
    $cmd.Parameters.Clear()
    if ($chk -and $chk -match 'DualWrite179 start' -and $chk -notmatch 'EXEC \[172\.16\.5\.179\].*;\s*;') {
      # ensure EXEC has args if remote expects them - check no trailing empty exec
      if ($chk -match 'uspEquimentCollection\]\s*;') {
        $log += "WARN empty exec $name"
      } else {
        $log += "APPLIED $name"
      }
    } elseif ($chk -and $chk -match 'DualWrite179 start') {
      $log += "APPLIED $name (check exec args)"
    } else {
      $log += "VERIFY_FAIL $name"
    }
  } catch {
    $log += "APPLY_ERR $name : $($_.Exception.Message)"
    try { Exec-Sql $c $def; $log += "RESTORED $name" }
    catch { $log += "RESTORE_FAIL $name : $($_.Exception.Message)" }
  }
}

$c.Close()
$text = $log -join "`r`n"
[System.IO.File]::WriteAllText((Join-Path $outDir 'dualwrite_sp_log.txt'), $text, [System.Text.UTF8Encoding]::new($false))
Write-Output 'OK'
Write-Output $text
