# iRacing Start Script - Simplified Version
# Launches essential iRacing applications with configurable options

# Application configuration - easy to modify paths and settings
$applications = @(
    @{ Name = "MOZA Pit House"; Path = "${env:ProgramFiles(x86)}\MOZA Pit House\MOZA Pit House.exe"; Enabled = $true; Args = @(); Color = "Cyan" }
    @{ Name = "CrewChief V4"; Path = "${env:ProgramFiles(x86)}\Britton IT Ltd\CrewChiefV4\CrewChiefV4.exe"; Enabled = $true; Args = @("-run_immediately"); Color = "Green" }
    @{ Name = "Trading Paints"; Path = "${env:ProgramFiles(x86)}\Rhinode LLC\Trading Paints\Trading Paints.exe"; Enabled = $true; Args = @(); Color = "Blue" }
    @{ Name = "irDashies"; Path = "$env:LOCALAPPDATA\irdashies\irDashies.exe"; Enabled = $true; Args = @(); Color = "Magenta" }
    @{ Name = "iRacing UI"; Path = "${env:ProgramFiles(x86)}\iRacing\ui\iRacingUI.exe"; Enabled = $true; Args = @(); Color = "Magenta" }
)

# Launch function - handles all the repetitive logic
function Start-Application($app) {
    if (-not $app.Enabled) { return }
    
    if (Test-Path $app.Path) {
        Write-Host "Launching $($app.Name)..." -ForegroundColor $app.Color
        Start-Process $app.Path -ArgumentList $app.Args
    } else {
        Write-Warning "$($app.Name) not found at: $($app.Path)"
    }
}

# Execute launches
$applications | ForEach-Object { Start-Application $_ }
Write-Host "All systems GO! See you on track." -ForegroundColor Yellow
