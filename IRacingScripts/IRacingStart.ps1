# iRacing Start Script
# This script is designed to launch all the essential applications for an iRacing session in one
# go. It includes MOZA Pit House, CrewChief V4, Trading Paints, irDashies, and the iRacing UI.
# Note: Update the paths to the executables if they are installed in different locations on your system.
$mozaPath = "C:\Program Files (x86)\MOZA Pit House\MOZA Pit House.exe"
$crewChiefPath = "C:\Program Files (x86)\Britton IT Ltd\CrewChiefV4\CrewChiefV4.exe"
$tradingPaintsPath = "C:\Program Files (x86)\Rhinode LLC\Trading Paints\Trading Paints.exe"
$irDashiesPath = "$env:LOCALAPPDATA\irdashies\irDashies.exe"
$iRacingUIPath = "C:\Program Files (x86)\iRacing\ui\iRacingUI.exe"

# Flags to control which applications to start (set to $false to skip launching)
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


# 4. irDashies (Usually in AppData for Electron apps)
if ($startIrDashies) {
    Write-Host "Launching irDashies..." -ForegroundColor Magenta
    if (Test-Path $irDashiesPath) {
        Write-Host "irDashies found at: $irDashiesPath" -ForegroundColor Green
        Start-Process $irDashiesPath
    } else {
        Write-Warning "irDashies not found at default path. Please update the script."
    }
}

# 5. iRacing UI
if ($startIracingUI) {
    if (Test-Path $iRacingUIPath) {
        Write-Host "Launching iRacing..." -ForegroundColor Red
        Start-Process $iRacingUIPath        
    } else {
        Write-Warning "iRacing UI not found at default path. Please update the script."
    }
}


Write-Host "All systems GO! See you on track." -ForegroundColor Yellow
