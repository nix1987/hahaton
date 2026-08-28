$ErrorActionPreference = 'Stop'
$log = 'C:\Users\n.voroncov\Documents\hahaton\tools\publish-result.txt'
function Write-Log($m) {
    Add-Content -LiteralPath $log -Value ("[{0}] {1}" -f (Get-Date -Format 'HH:mm:ss'), $m) -Encoding UTF8
}
'' | Set-Content -LiteralPath $log -Encoding UTF8
try {
    $webinst = 'C:\Program Files\1cv8\8.3.27.2342\bin\webinst.exe'
    $vrd = 'C:\Users\n.voroncov\Documents\hahaton\tools\default.vrd'
    $dir = 'C:\inetpub\wwwroot\InfoBase2'
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
    Write-Log "dir=$dir"
    $out = & $webinst -publish -iis -wsdir InfoBase2 -dir $dir -descriptor $vrd -connstr 'File="C:\Users\n.voroncov\Documents\InfoBase2";' 2>&1 | Out-String
    Write-Log "webinst exit=$LASTEXITCODE"
    Write-Log $out
    Copy-Item -LiteralPath $vrd -Destination (Join-Path $dir 'default.vrd') -Force
    Write-Log 'vrd restored'
    Get-ChildItem $dir | ForEach-Object { Write-Log ("file {0} {1}" -f $_.Name, $_.Length) }
    Write-Log 'SUCCESS'
}
catch {
    Write-Log ("ERROR: " + $_.Exception.Message)
    exit 1
}
