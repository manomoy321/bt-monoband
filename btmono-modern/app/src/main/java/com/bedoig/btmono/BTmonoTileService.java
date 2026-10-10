package com.bedoig.btmono;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.graphics.drawable.Icon;
import android.os.Build;
import android.service.quicksettings.Tile;
import android.service.quicksettings.TileService;
import android.util.Log;

import androidx.annotation.RequiresApi;

/**
 * BTmonoTileService
 * 
 * Android Quick Settings Tile (API 24+) allowing immediate 1-tap toggling
 * from the status bar notification tray without leaving or interrupting
 * the camera or video recording app.
 */
@RequiresApi(api = Build.VERSION_CODES.N)
public class BTmonoTileService extends TileService {

    private static final String TAG = "BTmonoTileService";
    private static boolean cachedActiveState = false;

    @Override
    public void onStartListening() {
        super.onStartListening();
        updateTile(cachedActiveState);
    }

    @Override
    public void onClick() {
        super.onClick();
        Tile tile = getQsTile();
        if (tile == null) return;

        boolean newActive = (tile.getState() != Tile.STATE_ACTIVE);
        cachedActiveState = newActive;

        Intent serviceIntent = new Intent(this, BTmonoService.class);
        if (newActive) {
            serviceIntent.setAction(BTmonoService.ACTION_START);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                startForegroundService(serviceIntent);
            } else {
                startService(serviceIntent);
            }
        } else {
            serviceIntent.setAction(BTmonoService.ACTION_STOP);
            startService(serviceIntent);
        }

        updateTile(newActive);
    }

    private void updateTile(boolean isActive) {
        Tile tile = getQsTile();
        if (tile == null) return;

        tile.setState(isActive ? Tile.STATE_ACTIVE : Tile.STATE_INACTIVE);
        tile.setLabel(getString(R.string.app_name));
        tile.setIcon(Icon.createWithResource(this, isActive ? R.drawable.ic_bt_active : R.drawable.ic_bt_inactive));

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            tile.setSubtitle(isActive ? "SCO Active" : "Off");
        }

        try {
            tile.updateTile();
        } catch (Exception e) {
            Log.e(TAG, "Error updating QS tile: " + e.getMessage());
        }
    }

    public static void requestTileUpdate(Context context, boolean isActive) {
        cachedActiveState = isActive;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            try {
                requestListeningState(context, new ComponentName(context, BTmonoTileService.class));
            } catch (Exception ignored) {}
        }
    }
}
