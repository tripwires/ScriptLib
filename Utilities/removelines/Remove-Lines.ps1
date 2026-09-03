param(
    [Parameter(Mandatory = $true)]
    [string]$InputFile,

    [Parameter(Mandatory = $true)]
    [string]$PhrasesFile,

    [string]$OutputFile = $InputFile
)

$phrases = Get-Content -LiteralPath $PhrasesFile | Where-Object { $_.Length -gt 0 }

Get-Content -LiteralPath $InputFile |
    Where-Object {
        $line = $_
        -not ($phrases | Where-Object { $line.Contains($_) })
    } |
    Set-Content -LiteralPath $OutputFile
