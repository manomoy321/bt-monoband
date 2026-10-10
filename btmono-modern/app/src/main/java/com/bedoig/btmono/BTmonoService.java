package com.bedoig.btmono;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ServiceInfo;
import android.os.Binder;
import android.os.Build;
import android.os.IBinder;
import android.util.Log;

import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;
import androidx.core.app.ServiceCompat;

/**
 * BTmonoService
 * 
 * Modern, robust foreground service that manages Bluetooth SCO / Communication device routing.
 * Compliant with Android 14+ (API 34/35) foreground service policies and Android 12+ PendingIntent immutability.
 */
public class BTmonoService extends Service {

    private static final String TAG = "BTmonoService";

    public static final String ACTION_START = "com.bedoig.btmono.ACTION_START";
    public static final String ACTION_STOP = "com.bedoig.btmono.ACTION_STOP";
    public static final String ACTION_TOGGLE = "com.bedoig.btmono.ACTION_TOGGLE";
    public static final String ACTION_STATUS_BROADCAST = "com.bedoig.btmono.ACTION_STATUS_BROADCAST";
    public static final String EXTRA_IS_ROUTING = "extra_is_routing";

    private static final String CHANNEL_ID = "btmono_routing_channel";
    private static final int NOTIFICATION_ID = 1001;

    private ModernAudioRouter audioRouter;
    private AppPreferences preferences;
    private final IBinder binder = new LocalBinder();

    public class LocalBinder extends Binder {
        public BTmonoService getService() {
            return BTmonoService.this;
        }
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return binder;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        CrashSafeExceptionHandler.install(this);
        audioRouter = new ModernAudioRouter(this);
        preferences = new AppPreferences(this);
        createNotificationChannel();
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        String action = (intent != null) ? intent.getAction() : ACTION_START;

        if (ACTION_STOP.equals(action)) {
            stopAudioRouting();
            stopSelf();
            return START_NOT_STICKY;
        } else if (ACTION_TOGGLE.equals(action)) {
            if (audioRouter.isRoutingActive()) {
                stopAudioRouting();
                stopSelf();
                return START_NOT_STICKY;
            } else {
                startAudioRouting();
            }
        } else {
            startAudioRouting();
        }

        return START_STICKY;
    }

    private void startAudioRouting() {
        // 1. Build and show Foreground Notification with Android 14+ service type
        Notification notification = buildNotification(true);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            ServiceCompat.startForeground(
                    this,
                    NOTIFICATION_ID,
                    notification,
                    ServiceInfo.FOREGROUND_SERVICE_TYPE_CONNECTED_DEVICE
            );
        } else {
            startForeground(NOTIFICATION_ID, notification);
        }

        // 2. Dispatch audio routing
        boolean success = audioRouter.startRouting();
        Log.i(TAG, "Audio routing started. Success: " + success);

        // 3. Launch floating camera HUD overlay if enabled
        if (preferences.isCameraOverlayEnabled()) {
            Intent overlayIntent = new Intent(this, CameraAudioOverlayService.class);
            overlayIntent.setAction(CameraAudioOverlayService.ACTION_SHOW_OVERLAY);
            overlayIntent.putExtra(CameraAudioOverlayService.EXTRA_IS_ACTIVE, true);
            startService(overlayIntent);
        }

        // 4. Update Quick Settings Tile & broadcast
        updateTileState(true);
        broadcastState(true);
    }

    private void stopAudioRouting() {
        Log.i(TAG, "Stopping audio routing.");
        audioRouter.stopRouting();

        // Hide floating camera HUD overlay
        Intent overlayIntent = new Intent(this, CameraAudioOverlayService.class);
        overlayIntent.setAction(CameraAudioOverlayService.ACTION_HIDE_OVERLAY);
        startService(overlayIntent);

        updateTileState(false);
        broadcastState(false);
        stopForeground(true);
    }

    private void createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel(
                    CHANNEL_ID,
                    "Bluetooth SCO Routing",
                    NotificationManager.IMPORTANCE_LOW
            );
            channel.setDescription("Shows active Bluetooth mono audio routing status");
            channel.setShowBadge(false);
            channel.setLockscreenVisibility(Notification.VISIBILITY_PUBLIC);

            NotificationManager manager = getSystemService(NotificationManager.class);
            if (manager != null) {
                manager.createNotificationChannel(channel);
            }
        }
    }

    private Notification buildNotification(boolean isActive) {
        int flag = Build.VERSION.SDK_INT >= Build.VERSION_CODES.M
                ? PendingIntent.FLAG_IMMUTABLE | PendingIntent.FLAG_UPDATE_CURRENT
                : PendingIntent.FLAG_UPDATE_CURRENT;

        // Intent to launch MainActivity on tap
        Intent openIntent = new Intent(this, MainActivity.class);
        PendingIntent pendingOpenIntent = PendingIntent.getActivity(this, 0, openIntent, flag);

        // Intent to Stop routing directly from notification action
        Intent stopIntent = new Intent(this, BTmonoService.class);
        stopIntent.setAction(ACTION_STOP);
        PendingIntent pendingStopIntent = PendingIntent.getService(this, 1, stopIntent, flag);

        NotificationCompat.Builder builder = new NotificationCompat.Builder(this, CHANNEL_ID)
                .setSmallIcon(R.drawable.ic_bt_active)
                .setContentTitle(getString(R.string.app_name))
                .setContentText(isActive ? "🟢 Audio actively routed to Bluetooth SCO" : "⚪ Standby")
                .setSubText("Mono Routing Active")
                .setContentIntent(pendingOpenIntent)
                .setOngoing(true)
                .setPriority(NotificationCompat.PRIORITY_LOW)
                .addAction(R.drawable.ic_stop, "Turn Off", pendingStopIntent);

        return builder.build();
    }

    private void updateTileState(boolean isActive) {
        BTmonoTileService.requestTileUpdate(this, isActive);
    }

    private void broadcastState(boolean isRouting) {
        Intent broadcast = new Intent(ACTION_STATUS_BROADCAST);
        broadcast.setPackage(getPackageName());
        broadcast.putExtra(EXTRA_IS_ROUTING, isRouting);
        sendBroadcast(broadcast);
    }

    public boolean isRoutingActive() {
        return audioRouter != null && audioRouter.isRoutingActive();
    }

    public String getAudioDiagnostics() {
        return audioRouter != null ? audioRouter.getStatusSummary() : "Offline";
    }

    @Override
    public void onDestroy() {
        stopAudioRouting();
        super.onDestroy();
    }
}
