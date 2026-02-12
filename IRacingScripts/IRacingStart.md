# iRacing Start Script

A simplified PowerShell script that launches all essential iRacing applications in one go, saving you time and ensuring you don't forget to start any critical tools before your racing session.

## What This Script Does

The script automatically launches these applications:
- **MOZA Pit House** - Hardware control software
- **CrewChief V4** - Voice spotter and race engineer 
- **Trading Paints** - Custom livery downloader
- **irDashies** - Dashboard and telemetry display
- **iRacing UI** - The main iRacing simulator

## Quick Start

1. **Run the script** by right-clicking on `IRacingStart.ps1` and selecting "Run with PowerShell"
   
   *OR*

   Open PowerShell, navigate to the script folder, and run:
   ```powershell
   .\IRacingStart.ps1
   ```

2. **Watch the applications launch** - Each app will display a colored message as it starts
3. **Get racing!** - You'll see "All systems GO! See you on track." when finished

## Configuration

### Enable/Disable Applications

To disable any application, change `Enabled = $true` to `Enabled = $false`:

```powershell
@{ Name = "MOZA Pit House"; Path = "..."; Enabled = $false; Args = @(); Color = "Cyan" }
```

### Update Installation Paths

If any application is installed in a different location, update the `Path` value:

```powershell
@{ Name = "CrewChief V4"; Path = "D:\Racing\CrewChiefV4\CrewChiefV4.exe"; Enabled = $true; Args = @("-run_immediately"); Color = "Green" }
```

### Add New Applications

To launch additional apps, add new entries to the `$applications` array:

```powershell
@{ Name = "My Racing App"; Path = "C:\Path\To\App.exe"; Enabled = $true; Args = @(); Color = "Yellow" }
```

## Customization Options

### Application Arguments
Some apps support command-line arguments. For example, CrewChief uses `-run_immediately` to start the audio engineer automatically:

```powershell
Args = @("-run_immediately")
```

To add multiple arguments:
```powershell
Args = @("-arg1", "-arg2", "value")
```

### Display Colors
Available colors: `Black`, `DarkBlue`, `DarkGreen`, `DarkCyan`, `DarkRed`, `DarkMagenta`, `DarkYellow`, `Gray`, `DarkGray`, `Blue`, `Green`, `Cyan`, `Red`, `Magenta`, `Yellow`, `White`

## Troubleshooting

### "Application not found" Warnings

If you see warnings like "Application not found at: [path]", the application isn't installed at the expected location:

1. **Find the correct path** - Right-click the app shortcut → Properties → Target
2. **Update the script** - Change the `Path` value in the configuration
3. **Re-run the script**

### PowerShell Execution Policy Error

If you get an execution policy error:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Applications Not Starting

- **Check if the executable exists** at the specified path
- **Verify you have permissions** to run the applications
- **Run PowerShell as administrator** if needed

## Default Installation Paths

The script uses these default installation paths:

| Application | Default Path |
|-------------|--------------|
| MOZA Pit House | `C:\Program Files (x86)\MOZA Pit House\MOZA Pit House.exe` |
| CrewChief V4 | `C:\Program Files (x86)\Britton IT Ltd\CrewChiefV4\CrewChiefV4.exe` |
| Trading Paints | `C:\Program Files (x86)\Rhinode LLC\Trading Paints\Trading Paints.exe` |
| irDashies | `%LOCALAPPDATA%\irdashies\irDashies.exe` |
| iRacing UI | `C:\Program Files (x86)\iRacing\ui\iRacingUI.exe` |

## Advanced Usage

### Create a Desktop Shortcut

1. Right-click on desktop → New → Shortcut
2. Location: `powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Users\miche\repos\scripts\IRacingScripts\IRacingStart.ps1"`
3. Name: "Start iRacing Setup"

### Run at System Startup

1. Press `Win + R`, type `shell:startup`
2. Copy the script or create a shortcut in the startup folder
3. Applications will launch automatically when Windows starts

### Silent Mode

To run without console output, modify the script or use:
```powershell
powershell.exe -WindowStyle Hidden -File ".\IRacingStart.ps1"
```

## Script Structure

The script uses a data-driven approach:
- **Configuration array** - All app settings in one place
- **Reusable function** - Single launch logic for all applications  
- **Pipeline processing** - Efficient execution using PowerShell best practices

This makes it easy to maintain, extend, and customize for your specific racing setup.

---

**Happy Racing!** 🏁