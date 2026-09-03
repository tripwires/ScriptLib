# PowerShell script to set microphone volume to 100% (via 99% first)
# This script uses Windows Core Audio APIs to control microphone volume

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

[Guid("5CDF2C82-841E-4546-9722-0CF74078229A"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
interface IAudioEndpointVolume {
    int NotImpl1();
    int NotImpl2();
    int GetChannelCount([Out] out int channelCount);
    int SetMasterVolumeLevel(float level, ref Guid eventContext);
    int SetMasterVolumeLevelScalar(float level, ref Guid eventContext);
    int GetMasterVolumeLevel([Out] out float level);
    int GetMasterVolumeLevelScalar([Out] out float level);
    int SetChannelVolumeLevel(int channelNumber, float level, ref Guid eventContext);
    int SetChannelVolumeLevelScalar(int channelNumber, float level, ref Guid eventContext);
    int GetChannelVolumeLevel(int channelNumber, [Out] out float level);
    int GetChannelVolumeLevelScalar(int channelNumber, [Out] out float level);
    int SetMute([MarshalAs(UnmanagedType.Bool)] bool isMuted, ref Guid eventContext);
    int GetMute([Out, MarshalAs(UnmanagedType.Bool)] out bool isMuted);
    int GetVolumeStepInfo([Out] out int step, [Out] out int stepCount);
    int VolumeStepUp(ref Guid eventContext);
    int VolumeStepDown(ref Guid eventContext);
    int QueryHardwareSupport([Out] out int hardwareSupportMask);
    int GetVolumeRange([Out] out float volumeMin, [Out] out float volumeMax, [Out] out float volumeStep);
}

[Guid("D666063F-1587-4E43-81F1-B948E807363F"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
interface IMMDevice {
    int Activate(ref Guid id, int clsCtx, int activationParams, [Out, MarshalAs(UnmanagedType.IUnknown)] out object interfacePointer);
    int OpenPropertyStore(int stgmAccess, [Out] out IntPtr properties);
    int GetId([Out, MarshalAs(UnmanagedType.LPWStr)] out string id);
    int GetState([Out] out int state);
}

[Guid("A95664D2-9614-4F35-A746-DE8DB63617E6"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
interface IMMDeviceEnumerator {
    int EnumAudioEndpoints(int dataFlow, int stateMask, [Out] out IntPtr devices);
    int GetDefaultAudioEndpoint(int dataFlow, int role, [Out] out IMMDevice endpoint);
    int GetDevice(string id, [Out] out IMMDevice device);
    int RegisterEndpointNotificationCallback(IntPtr client);
    int UnregisterEndpointNotificationCallback(IntPtr client);
}

[ComImport]
[Guid("BCDE0395-E52F-467C-8E3D-C4579291692E")]
class MMDeviceEnumerator {
}

public class AudioManager {
    public static void SetMicrophoneVolume(float volume) {
        try {
            var deviceEnumerator = (IMMDeviceEnumerator)(new MMDeviceEnumerator());
            IMMDevice device;
            deviceEnumerator.GetDefaultAudioEndpoint(1, 0, out device); // 1 = eCapture (microphone), 0 = eConsole
            
            object aevObj;
            var audioEndpointVolumeGuid = typeof(IAudioEndpointVolume).GUID;
            device.Activate(ref audioEndpointVolumeGuid, 0, 0, out aevObj);
            var audioEndpointVolume = (IAudioEndpointVolume)aevObj;
            
            var eventContext = Guid.Empty;
            audioEndpointVolume.SetMasterVolumeLevelScalar(volume, ref eventContext);
        } catch (Exception ex) {
            throw new Exception("Failed to set microphone volume: " + ex.Message);
        }
    }
    
    public static float GetMicrophoneVolume() {
        try {
            var deviceEnumerator = (IMMDeviceEnumerator)(new MMDeviceEnumerator());
            IMMDevice device;
            deviceEnumerator.GetDefaultAudioEndpoint(1, 0, out device); // 1 = eCapture (microphone)
            
            object aevObj;
            var audioEndpointVolumeGuid = typeof(IAudioEndpointVolume).GUID;
            device.Activate(ref audioEndpointVolumeGuid, 0, 0, out aevObj);
            var audioEndpointVolume = (IAudioEndpointVolume)aevObj;
            
            float volume;
            audioEndpointVolume.GetMasterVolumeLevelScalar(out volume);
            return volume;
        } catch (Exception ex) {
            throw new Exception("Failed to get microphone volume: " + ex.Message);
        }
    }
}
"@

function Set-MicrophoneVolume {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateRange(0, 100)]
        [int]$VolumePercentage
    )
    
    try {
        $volumeScalar = $VolumePercentage / 100.0
        [AudioManager]::SetMicrophoneVolume($volumeScalar)
        Write-Host "Microphone volume set to $VolumePercentage%" -ForegroundColor Green
    } catch {
        Write-Error "Failed to set microphone volume: $($_.Exception.Message)"
        return $false
    }
    return $true
}

function Get-MicrophoneVolume {
    try {
        $volumeScalar = [AudioManager]::GetMicrophoneVolume()
        $volumePercentage = [Math]::Round($volumeScalar * 100)
        return $volumePercentage
    } catch {
        Write-Error "Failed to get microphone volume: $($_.Exception.Message)"
        return $null
    }
}

# Main execution
try {
    Write-Host "Getting current microphone volume..." -ForegroundColor Cyan
    $currentVolume = Get-MicrophoneVolume
    if ($null -ne $currentVolume) {
        Write-Host "Current microphone volume: $currentVolume%" -ForegroundColor Yellow
    }
    
    Write-Host "Setting microphone volume to 99%..." -ForegroundColor Cyan
    $success = Set-MicrophoneVolume -VolumePercentage 99
    
    if ($success) {
        Start-Sleep -Milliseconds 500  # Short delay to ensure the change takes effect
        
        Write-Host "Setting microphone volume to 100%..." -ForegroundColor Cyan
        $success = Set-MicrophoneVolume -VolumePercentage 100
        
        if ($success) {
            Write-Host "Successfully set microphone volume to 100% (via 99%)" -ForegroundColor Green
            
            # Verify the final volume
            Start-Sleep -Milliseconds 200
            $finalVolume = Get-MicrophoneVolume
            if ($null -ne $finalVolume) {
                Write-Host "Final microphone volume: $finalVolume%" -ForegroundColor Yellow
            }
        } else {
            Write-Error "Failed to set microphone volume to 100%"
        }
    } else {
        Write-Error "Failed to set microphone volume to 99%"
    }
} catch {
    Write-Error "Script execution failed: $($_.Exception.Message)"
    exit 1
}
