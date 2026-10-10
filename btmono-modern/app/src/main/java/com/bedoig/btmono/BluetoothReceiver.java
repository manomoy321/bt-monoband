package com.bedoig.btmono;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.media.AudioManager;
import android.util.Log;

/**
 * BluetoothReceiver
 * 
 * Automatically monitors Bluetooth lifecycle events:
 * - If Bluetooth is turned off, or headset disconnects, automatically stops routing
 *   and restores AudioManager mode to normal to prevent audio hangs or muffled calls.
 */
public class BluetoothReceiver extends BroadcastReceiver {

    private static final String TAG = "BluetoothReceiver";

    @Override
    public void onReceive(Context context, Intent intent) {
        if (intent == null || intent.getAction() == null) return;

        String action = intent.getAction();

        if (BluetoothAdapter.ACTION_STATE_CHANGED.equals(action)) {
            int state = intent.getIntExtra(BluetoothAdapter.EXTRA_STATE, BluetoothAdapter.ERROR);
            if (state == BluetoothAdapter.STATE_TURNING_OFF || state == BluetoothAdapter.STATE_OFF) {
                Log.w(TAG, "Bluetooth turned off. Disabling audio routing.");
                stopRoutingService(context);
            }
        } else if (BluetoothDevice.ACTION_ACL_DISCONNECTED.equals(action)) {
            Log.w(TAG, "Bluetooth device disconnected. Ensuring audio routing cleanup.");
            stopRoutingService(context);
        } else if (AudioManager.ACTION_SCO_AUDIO_STATE_UPDATED.equals(action)) {
            int scoState = intent.getIntExtra(AudioManager.EXTRA_SCO_AUDIO_STATE, AudioManager.SCO_AUDIO_STATE_ERROR);
            Log.d(TAG, "SCO Audio State changed: " + scoState);
            if (scoState == AudioManager.SCO_AUDIO_STATE_DISCONNECTED) {
                // SCO session ended
            }
        }
    }

    private void stopRoutingService(Context context) {
        Intent serviceIntent = new Intent(context, BTmonoService.class);
        serviceIntent.setAction(BTmonoService.ACTION_STOP);
        context.startService(serviceIntent);
    }
}
