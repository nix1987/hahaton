$ErrorActionPreference = "Stop"

try {
	$null = [Console]::In.ReadToEnd()
} catch {
	# stdin may be empty
}

$signalPath = Join-Path (Get-Location) "exchange\request.signal"

if (Test-Path -LiteralPath $signalPath) {
	$context = "Обнаружен сигнал exchange/request.signal. Прочитай exchange/cars-request.json, найди средние цены на avito.ru и auto.ru, запиши exchange/cars-prices.json и exchange/response.signal с текстом PRICE_RESPONSE, затем удали exchange/request.signal."
	@{ additional_context = $context } | ConvertTo-Json -Compress
	exit 0
}

Write-Output "{}"
exit 0
