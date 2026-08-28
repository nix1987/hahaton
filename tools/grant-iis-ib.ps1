$ErrorActionPreference = 'Stop'
$log = 'C:\Users\n.voroncov\Documents\hahaton\tools\publish-acl-result.txt'
function Write-Log($m) { Add-Content -LiteralPath $log -Value $m -Encoding UTF8 }
'' | Set-Content -LiteralPath $log -Encoding UTF8
$paths = @(
    @{ Path = 'C:\Users\n.voroncov'; Grant = 'IIS_IUSRS:(RX)' },
    @{ Path = 'C:\Users\n.voroncov\Documents'; Grant = 'IIS_IUSRS:(RX)' },
    @{ Path = 'C:\Users\n.voroncov\Documents\InfoBase2'; Grant = 'IIS_IUSRS:(OI)(CI)M' }
)
foreach ($item in $paths) {
    $out = & icacls $item.Path /grant $item.Grant 2>&1 | Out-String
    Write-Log ("{0} {1}" -f $item.Path, $out)
}
$poolGrant = & icacls 'C:\Users\n.voroncov\Documents\InfoBase2' /grant 'IIS APPPOOL\DefaultAppPool:(OI)(CI)M' /T 2>&1 | Out-String
Write-Log $poolGrant
Write-Log 'DONE'
