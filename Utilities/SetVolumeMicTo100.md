# Microphone Volume Control Script

## Overview

`SetVolumeMicTo100.ps1` is a PowerShell script that sets the default microphone volume to 100% using a two-step process: first setting it to 99%, then to 100%. This approach can help ensure proper audio driver initialization and volume level application.

## Features

- **Direct Windows Audio API Integration**: Uses COM interfaces to communicate directly with Windows Core Audio APIs
- **Two-Step Volume Setting**: Sets volume to 99% first, then 100% to ensure proper driver response
- **Volume Verification**: Displays current volume before changes and final volume after completion
- **Error Handling**: Comprehensive error checking with descriptive error messages
- **Visual Feedback**: Color-coded console output for easy monitoring of script progress
- **Modular Functions**: Includes reusable functions for getting and setting microphone volume

## How It Works

1. **Initial Volume Check**: Retrieves and displays the current microphone volume level
2. **First Volume Set**: Sets the microphone volume to 99%
3. **Delay**: Waits 500ms to ensure the volume change is processed by the audio driver
4. **Final Volume Set**: Sets the microphone volume to 100%
5. **Verification**: Retrieves and displays the final volume level to confirm success

## Technical Details

### Core Components

- **IAudioEndpointVolume Interface**: COM interface for controlling audio endpoint volume
- **IMMDevice Interface**: COM interface for accessing multimedia devices
- **IMMDeviceEnumerator Interface**: COM interface for enumerating audio devices
- **AudioManager Class**: C# class wrapper for audio operations

### Functions

#### `Set-MicrophoneVolume`
Sets the microphone volume to a specified percentage.

**Parameters:**
- `VolumePercentage` (int, 0-100): The desired volume level

**Returns:**
- `$true` if successful, `$false` if failed

#### `Get-MicrophoneVolume`
Retrieves the current microphone volume level.

**Returns:**
- Volume percentage (int, 0-100) or `$null` if failed

## Usage

### Basic Usage
Simply run the script to perform the two-step volume setting:

```powershell
.\SetVolumeMicTo100.ps1
```

### Using Individual Functions
After the script has been loaded, you can use the functions independently:

```powershell
# Get current microphone volume
$currentVolume = Get-MicrophoneVolume
Write-Host "Current volume: $currentVolume%"

# Set microphone volume to a specific level
Set-MicrophoneVolume -VolumePercentage 75
```

## Requirements

- **Operating System**: Windows Vista or later
- **PowerShell**: Version 2.0 or later
- **Permissions**: Standard user permissions (no administrator rights required)
- **Audio Drivers**: Compatible Windows audio drivers

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

## Error Handling

The script includes comprehensive error handling for common scenarios:

- **No Audio Device**: If no default microphone is found
- **COM Interface Errors**: If Windows audio APIs are unavailable
- **Permission Issues**: If audio device access is restricted
- **Driver Problems**: If audio drivers don't respond properly

## Troubleshooting

### Script Doesn't Work
1. Ensure you have a default microphone device set in Windows
2. Check that your audio drivers are properly installed
3. Verify PowerShell execution policy allows script execution
4. Run PowerShell as Administrator if permission issues occur

### Volume Doesn't Change
1. Check if the microphone is muted in Windows settings
2. Verify the correct microphone is set as the default recording device
3. Some USB microphones may require driver-specific software

### COM Interface Errors
1. Restart the Windows Audio service
2. Update audio drivers
3. Check for Windows system updates

## File Location

This script is part of the utilities collection in:
`c:\Users\miche\repos\scripts\Utilities\`

## Related Files

- `SetVolumeMicTo100.ps1` - The main PowerShell script
- `README.md` - General utilities documentation (if available)

## Version History

- **v1.0** - Initial release with two-step volume setting functionality