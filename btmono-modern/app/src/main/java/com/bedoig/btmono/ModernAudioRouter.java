package com.bedoig.btmono;

import android.content.Context;
import android.media.AudioDeviceInfo;
import android.media.AudioManager;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;

import java.util.List;

/**
 * ModernAudioRouter
 * 
 * Provides unified, crash-safe Bluetooth SCO and BLE Audio routing.
 * Seamlessly transitions between:
 *  - Android 12+ (API 31–35+): AudioManager.setCommunicationDevice()
 *  - Android 5.0–11 (API 21–30): AudioManager.startBluetoothSco() & setBluetoothScoOn()
 */
public class ModernAudioRouter {

    private static final String TAG = "ModernAudioRouter";

    private final Context context;
    private final AudioManager audioManager;
    private boolean isRoutingActive = false;

    // Listener for API 31+
    private AudioManager.OnCommunicationDeviceChangedListener deviceChangedListener;

    public ModernAudioRouter(@NonNull Context context) {
        this.context = context.getApplicationContext();
        this.audioManager = (AudioManager) this.context.getSystemService(Context.AUDIO_SERVICE);
    }

    /**
     * Starts routing all system audio to the Bluetooth SCO / Headset channel.
     * @return true if routing request was successfully dispatched.
     */
    public synchronized boolean startRouting() {
        if (audioManager == null) {
            Log.e(TAG, "AudioManager is null. Cannot route audio.");
            return false;
        }

        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                // Android 12+ (API 31+) Modern Audio Routing
                AudioDeviceInfo scoDevice = findBluetoothCommunicationDevice();
                if (scoDevice != null) {
                    boolean success = audioManager.setCommunicationDevice(scoDevice);
                    Log.i(TAG, "setCommunicationDevice: " + scoDevice.getProductName() + " -> " + success);
                    
                    // Listen for changes/disconnections
                    if (deviceChangedListener == null) {
                        deviceChangedListener = device -> {
                            Log.d(TAG, "Communication device changed: " + (device != null ? device.getProductName() : "none"));
                        };
                        audioManager.addOnCommunicationDeviceChangedListener(context.getMainExecutor(), deviceChangedListener);
                    }
                } else {
                    Log.w(TAG, "No Bluetooth SCO/BLE communication device found in getAvailableCommunicationDevices().");
                }

                // Set mode to MODE_IN_COMMUNICATION so media/camera apps use communication routing
                audioManager.setMode(AudioManager.MODE_IN_COMMUNICATION);

            } else {
                // Legacy Android 5.0 - 11 (API 21 - 30) SCO Routing
                audioManager.setMode(AudioManager.MODE_IN_COMMUNICATION);
                audioManager.setBluetoothScoOn(true);
                audioManager.startBluetoothSco();
                Log.i(TAG, "Legacy startBluetoothSco called.");
            }

            isRoutingActive = true;
            return true;

        } catch (SecurityException se) {
            Log.e(TAG, "Missing BLUETOOTH_CONNECT permission: " + se.getMessage(), se);
            forceReset();
            return false;
        } catch (Exception e) {
            Log.e(TAG, "Unexpected error starting audio routing: " + e.getMessage(), e);
            forceReset();
            return false;
        }
    }

    /**
     * Stops audio routing and cleanly restores normal system audio.
     */
    public synchronized void stopRouting() {
        if (audioManager == null) return;

        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                if (deviceChangedListener != null) {
                    try {
                        audioManager.removeOnCommunicationDeviceChangedListener(deviceChangedListener);
                    } catch (Exception ignored) {}
                    deviceChangedListener = null;
                }
                audioManager.clearCommunicationDevice();
                Log.i(TAG, "clearCommunicationDevice() called.");
            } else {
                audioManager.stopBluetoothSco();
                audioManager.setBluetoothScoOn(false);
                Log.i(TAG, "Legacy stopBluetoothSco called.");
            }

            // Always restore system audio mode back to MODE_NORMAL
            audioManager.setMode(AudioManager.MODE_NORMAL);
            isRoutingActive = false;
            Log.i(TAG, "Audio mode cleanly restored to MODE_NORMAL.");

        } catch (Exception e) {
            Log.e(TAG, "Error while stopping audio routing: " + e.getMessage(), e);
            forceReset();
        }
    }

    /**
     * Fail-safe reset method: Guarantees audio mode is restored even during unhandled exceptions.
     */
    public synchronized void forceReset() {
        if (audioManager == null) return;
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                audioManager.clearCommunicationDevice();
            } else {
                audioManager.stopBluetoothSco();
                audioManager.setBluetoothScoOn(false);
            }
        } catch (Exception ignored) {}

        try {
            audioManager.setMode(AudioManager.MODE_NORMAL);
        } catch (Exception ignored) {}

        isRoutingActive = false;
    }

    /**
     * Searches available communication devices for SCO or BLE Headsets on Android 12+.
     */
    private AudioDeviceInfo findBluetoothCommunicationDevice() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S && audioManager != null) {
            List<AudioDeviceInfo> devices = audioManager.getAvailableCommunicationDevices();
            for (AudioDeviceInfo info : devices) {
                int type = info.getType();
                if (type == AudioDeviceInfo.TYPE_BLUETOOTH_SCO) {
                    return info;
                }
            }
            // Fallback: check BLE Headset
            for (AudioDeviceInfo info : devices) {
                if (info.getType() == AudioDeviceInfo.TYPE_BLE_HEADSET) {
                    return info;
                }
            }
        }
        return null;
    }

    public boolean isRoutingActive() {
        return isRoutingActive;
    }

    /**
     * Returns diagnostic description of the current audio state.
     */
    public String getStatusSummary() {
        if (audioManager == null) return "Audio Manager unavailable";

        int mode = audioManager.getMode();
        String modeStr = (mode == AudioManager.MODE_IN_COMMUNICATION) ? "COMMUNICATION" :
                         (mode == AudioManager.MODE_IN_CALL) ? "IN_CALL" : "NORMAL";

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            AudioDeviceInfo commDevice = audioManager.getCommunicationDevice();
            String deviceName = commDevice != null ? commDevice.getProductName().toString() : "None";
            return "Mode: " + modeStr + " | Device: " + deviceName + " (Active: " + isRoutingActive + ")";
        } else {
            boolean scoOn = audioManager.isBluetoothScoOn();
            return "Mode: " + modeStr + " | SCO On: " + scoOn + " (Active: " + isRoutingActive + ")";
        }
    }
}
