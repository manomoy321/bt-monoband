package com.bedoig.btmono;

import android.content.Context;
import android.content.SharedPreferences;

import androidx.preference.PreferenceManager;

public class AppPreferences {

    private static final String PREF_AUTO_ON = "pref_auto_on";
    private static final String PREF_COLOR = "pref_color";
    private static final String PREF_CAMERA_OVERLAY = "pref_camera_overlay";
    private static final String PREF_LAST_VOLUME = "pref_last_volume";

    private final SharedPreferences prefs;

    public AppPreferences(Context context) {
        this.prefs = PreferenceManager.getDefaultSharedPreferences(context.getApplicationContext());
    }

    public boolean isAutoOn() {
        return prefs.getBoolean(PREF_AUTO_ON, false);
    }

    public void setAutoOn(boolean autoOn) {
        prefs.edit().putBoolean(PREF_AUTO_ON, autoOn).apply();
    }

    public boolean isCameraOverlayEnabled() {
        return prefs.getBoolean(PREF_CAMERA_OVERLAY, true);
    }

    public void setCameraOverlayEnabled(boolean enabled) {
        prefs.edit().putBoolean(PREF_CAMERA_OVERLAY, enabled).apply();
    }

    public String getColorTheme() {
        return prefs.getString(PREF_COLOR, "5"); // Default: 5 (Green)
    }

    public void setColorTheme(String color) {
        prefs.edit().putString(PREF_COLOR, color).apply();
    }

    public int getLastVolume() {
        return prefs.getInt(PREF_LAST_VOLUME, -1);
    }

    public void setLastVolume(int volume) {
        prefs.edit().putInt(PREF_LAST_VOLUME, volume).apply();
    }
}
