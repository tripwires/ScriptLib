$mozaPath = "C:\Program Files (x86)\MOZA Pit House\MOZA Pit House.exe"
$crewChiefPath = "C:\Program Files (x86)\Britton IT Ltd\CrewChiefV4\CrewChiefV4.exe"
$tradingPaintsPath = "C:\Program Files (x86)\Rhinode LLC\Trading Paints\Trading Paints.exe"
$irDashiesPath = "$env:LOCALAPPDATA\irdashies\irDashies.exe"
$iRacingUIPath = "C:\Program Files (x86)\iRacing\ui\iRacingUI.exe"

$startMoza = $true;
$startCrewChief = $true;
$startTradingPaints = $true;
$startIrDashies = $true;
$startIracingUI = $true;


# 1. MOZA Pit House
if ($startMoza) {
    if (Test-Path $mozaPath) {
        Write-Host "Launching MOZA Pit House..." -ForegroundColor Cyan
        Start-Process $mozaPath
    } else {
        Write-Warning "MOZA Pit House not found at default path. Please update the script."
    }
}

# 2. CrewChief V4
if ($startCrewChief) {
    if (Test-Path $crewChiefPath) {
        Write-Host "Launching CrewChief..." -ForegroundColor Green
        # The '-run_immediately' flag tells CrewChief to start the audio engineer right away
        Start-Process $crewChiefPath -ArgumentList "-run_immediately"
    } else {
        Write-Warning "CrewChief not found at default path. Please update the script."
    }
}

# 3. Trading Paints
if ($startTradingPaints) {
    if (Test-Path $tradingPaintsPath) {
        Write-Host "Launching Trading Paints..." -ForegroundColor Blue
        # Standard path for the Trading Paints Downloader
        Start-Process $tradingPaintsPath
    } else {
        Write-Warning "Trading Paints not found at default path. Please update the script."
    }
}


# 3. irDashies (Usually in AppData for Electron apps)
if ($startIrDashies) {
    Write-Host "Launching irDashies..." -ForegroundColor Magenta
    if (Test-Path $irDashiesPath) {
        Write-Host "irDashies found at: $irDashiesPath" -ForegroundColor Green
        Start-Process $irDashiesPath
    } else {
        Write-Warning "irDashies not found at default path. Please update the script."
    }
}

# 4. iRacing UI
if ($startIracingUI) {
    if (Test-Path $iRacingUIPath) {
        Write-Host "Launching iRacing..." -ForegroundColor Red
        Start-Process $iRacingUIPath        
    } else {
        Write-Warning "iRacing UI not found at default path. Please update the script."
    }
}


Write-Host "All systems GO! See you on track." -ForegroundColor Yellow
