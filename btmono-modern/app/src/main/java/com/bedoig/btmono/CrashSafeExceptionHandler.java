package com.bedoig.btmono;

import android.content.Context;
import android.media.AudioManager;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;

/**
 * CrashSafeExceptionHandler
 * 
 * Safety watchdog that intercepts any unexpected uncaught exceptions and guarantees
 * that Android system audio is cleanly restored to MODE_NORMAL before the crash handler
 * terminates. This prevents devices from getting locked in muffled communication/phone call mode.
 */
public class CrashSafeExceptionHandler implements Thread.UncaughtExceptionHandler {

    private static final String TAG = "CrashSafeWatchdog";
    private final Context context;
    private final Thread.UncaughtExceptionHandler defaultHandler;

    public CrashSafeExceptionHandler(Context context) {
        this.context = context.getApplicationContext();
        this.defaultHandler = Thread.getDefaultUncaughtExceptionHandler();
    }

    public static void install(Context context) {
        Thread.setDefaultUncaughtExceptionHandler(new CrashSafeExceptionHandler(context));
    }

    @Override
    public void uncaughtException(@NonNull Thread t, @NonNull Throwable e) {
        Log.e(TAG, "Uncaught exception detected: " + e.getMessage(), e);

        // Emergency teardown of audio routing
        try {
            AudioManager am = (AudioManager) context.getSystemService(Context.AUDIO_SERVICE);
            if (am != null) {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                    am.clearCommunicationDevice();
                } else {
                    am.stopBluetoothSco();
                    am.setBluetoothScoOn(false);
                }
                am.setMode(AudioManager.MODE_NORMAL);
                Log.w(TAG, "Emergency audio mode reset to MODE_NORMAL executed.");
            }
        } catch (Exception resetEx) {
            Log.e(TAG, "Failed emergency audio reset: " + resetEx.getMessage());
        }

        // Pass to standard default system crash handler
        if (defaultHandler != null) {
            defaultHandler.uncaughtException(t, e);
        }
    }
}
