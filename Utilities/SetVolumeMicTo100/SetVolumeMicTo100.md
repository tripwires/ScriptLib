# Microphone Volume Control Script

A PowerShell script that reliably sets your default microphone volume to 100% using a two-step process to ensure proper audio driver response.

## What This Script Does

The script performs a simple but effective sequence:
- **Check current volume** - Shows your microphone's starting volume level
- **Set to 99%** - First adjustment to prime the audio driver
- **Set to 100%** - Final adjustment to reach maximum volume
- **Verify results** - Confirms the volume was set correctly

This two-step approach helps ensure that Windows audio drivers properly apply the volume change, which can sometimes fail with direct adjustments to 100%.

## Quick Start

1. **Run the script** by right-clicking on `SetVolumeMicTo100.ps1` and selecting "Run with PowerShell"
   
   *OR*

   Open PowerShell, navigate to the script folder, and run:
   ```powershell
   .\SetVolumeMicTo100.ps1
   ```

2. **Watch the progress** - You'll see colored messages showing each step
3. **Volume set!** - Your microphone will be at 100% volume when complete

## Sample Output

```
Getting current microphone volume...
Current microphone volume: 85%
Setting microphone volume to 99%...
Microphone volume set to 99%
Setting microphone volume to 100%...
Microphone volume set to 100%
Successfully set microphone volume to 100% (via 99%)
Final microphone volume: 100%
```

## Advanced Usage

### Using Individual Functions

After running the script once, you can use the built-in functions for custom volume control:

```powershell
# Get current microphone volume
$currentVolume = Get-MicrophoneVolume
Write-Host "Current volume: $currentVolume%"

# Set microphone volume to any level (0-100)
Set-MicrophoneVolume -VolumePercentage 75
```

### Integration with Other Scripts

You can call this script from other automation scripts:
```powershell
# Call from another PowerShell script
& "C:\Users\YourName\repos\scripts\Utilities\SetVolumeMicTo100.ps1"
```

## Troubleshooting

### "No Audio Device Found" Error

If you see this error:
1. **Check your microphone** - Ensure it's plugged in and recognized by Windows
2. **Set as default** - Go to Sound Settings → Input and select your microphone as default
3. **Update drivers** - Update your audio drivers through Device Manager

### Volume Doesn't Change

If the script runs without errors but volume doesn't change:
1. **Check Windows settings** - Ensure the microphone isn't muted in Sound Settings
2. **Try as administrator** - Right-click PowerShell and "Run as administrator"
3. **Restart audio service** - Open Services and restart "Windows Audio"

### PowerShell Execution Policy Error

If you get an execution policy error:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## Requirements

- **Windows**: Vista or later (Windows 10/11 recommended)
- **PowerShell**: Version 2.0 or later
- **Default microphone**: Must have a microphone set as Windows default recording device

---

**Need perfect mic levels?** This script has you covered! 🎙️