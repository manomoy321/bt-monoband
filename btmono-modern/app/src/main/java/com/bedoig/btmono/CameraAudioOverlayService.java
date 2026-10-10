package com.bedoig.btmono;

import android.annotation.SuppressLint;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.PixelFormat;
import android.graphics.drawable.GradientDrawable;
import android.os.Build;
import android.os.IBinder;
import android.provider.Settings;
import android.util.Log;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.Nullable;

/**
 * CameraAudioOverlayService
 * 
 * Provides an unobtrusive, crash-safe floating status HUD designed to remain visible
 * while using any Android OS default Camera application.
 * 
 * Allows users to monitor Bluetooth SCO microphone/audio routing status and toggle
 * routing directly without interrupting or closing video/photo recording.
 */
public class CameraAudioOverlayService extends Service {

    private static final String TAG = "CameraOverlayService";

    public static final String ACTION_SHOW_OVERLAY = "com.bedoig.btmono.ACTION_SHOW_OVERLAY";
    public static final String ACTION_HIDE_OVERLAY = "com.bedoig.btmono.ACTION_HIDE_OVERLAY";
    public static final String ACTION_UPDATE_STATUS = "com.bedoig.btmono.ACTION_UPDATE_STATUS";
    public static final String EXTRA_IS_ACTIVE = "extra_is_active";

    private WindowManager windowManager;
    private View overlayView;
    private WindowManager.LayoutParams layoutParams;
    private TextView statusTextView;
    private ImageView indicatorDot;

    private boolean isOverlayAdded = false;

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        windowManager = (WindowManager) getSystemService(Context.WINDOW_SERVICE);
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (intent == null) return START_NOT_STICKY;

        String action = intent.getAction();
        if (ACTION_SHOW_OVERLAY.equals(action)) {
            boolean isActive = intent.getBooleanExtra(EXTRA_IS_ACTIVE, true);
            showOverlay(isActive);
        } else if (ACTION_HIDE_OVERLAY.equals(action)) {
            hideOverlay();
        } else if (ACTION_UPDATE_STATUS.equals(action)) {
            boolean isActive = intent.getBooleanExtra(EXTRA_IS_ACTIVE, false);
            updateOverlayContent(isActive);
        }

        return START_NOT_STICKY;
    }

    @SuppressLint("ClickableViewAccessibility")
    private void showOverlay(boolean isActive) {
        // Crash-safe check: overlay permission must be present
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (!Settings.canDrawOverlays(this)) {
                Log.w(TAG, "Cannot show overlay: SYSTEM_ALERT_WINDOW permission not granted.");
                return;
            }
        }

        if (isOverlayAdded) {
            updateOverlayContent(isActive);
            return;
        }

        try {
            int overlayType = (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
                    ? WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
                    : WindowManager.LayoutParams.TYPE_PHONE;

            layoutParams = new WindowManager.LayoutParams(
                    WindowManager.LayoutParams.WRAP_CONTENT,
                    WindowManager.LayoutParams.WRAP_CONTENT,
                    overlayType,
                    WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE |
                    WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
                    PixelFormat.TRANSLUCENT
            );

            layoutParams.gravity = Gravity.TOP | Gravity.START;
            layoutParams.x = 40;
            layoutParams.y = 120; // Safe position below standard status bar

            // Build elegant floating pill view programmatically for 100% crash safety
            overlayView = createPillView();
            updateOverlayContent(isActive);

            // Drag listener so user can reposition anywhere over camera view
            overlayView.setOnTouchListener(new View.OnTouchListener() {
                private int initialX, initialY;
                private float initialTouchX, initialTouchY;

                @Override
                public boolean onTouch(View v, MotionEvent event) {
                    switch (event.getAction()) {
                        case MotionEvent.ACTION_DOWN:
                            initialX = layoutParams.x;
                            initialY = layoutParams.y;
                            initialTouchX = event.getRawX();
                            initialTouchY = event.getRawY();
                            return true;

                        case MotionEvent.ACTION_MOVE:
                            layoutParams.x = initialX + (int) (event.getRawX() - initialTouchX);
                            layoutParams.y = initialY + (int) (event.getRawY() - initialTouchY);
                            try {
                                windowManager.updateViewLayout(overlayView, layoutParams);
                            } catch (Exception ignored) {}
                            return true;

                        case MotionEvent.ACTION_UP:
                            float dx = event.getRawX() - initialTouchX;
                            float dy = event.getRawY() - initialTouchY;
                            if (Math.abs(dx) < 15 && Math.abs(dy) < 15) {
                                // Tap event: toggle audio routing directly
                                toggleAudioRouting();
                            }
                            return true;
                    }
                    return false;
                }
            });

            windowManager.addView(overlayView, layoutParams);
            isOverlayAdded = true;
            Log.i(TAG, "Floating Camera HUD overlay added successfully.");

        } catch (Exception e) {
            Log.e(TAG, "Failed to display overlay: " + e.getMessage(), e);
            isOverlayAdded = false;
        }
    }

    private View createPillView() {
        LinearLayout pillLayout = new LinearLayout(this);
        pillLayout.setOrientation(LinearLayout.HORIZONTAL);
        pillLayout.setGravity(Gravity.CENTER_VERTICAL);
        pillLayout.setPadding(30, 16, 30, 16);

        // Rounded pill background with glassmorphism dark styling
        GradientDrawable background = new GradientDrawable();
        background.setShape(GradientDrawable.RECTANGLE);
        background.setCornerRadius(60f);
        background.setColor(Color.argb(215, 20, 24, 30)); // Sleek dark slate
        background.setStroke(3, Color.argb(160, 76, 175, 80)); // Green subtle accent
        pillLayout.setBackground(background);

        // Status indicator dot
        indicatorDot = new ImageView(this);
        GradientDrawable dotBg = new GradientDrawable();
        dotBg.setShape(GradientDrawable.OVAL);
        dotBg.setSize(24, 24);
        dotBg.setColor(Color.parseColor("#4CAF50"));
        indicatorDot.setImageDrawable(dotBg);

        LinearLayout.LayoutParams dotParams = new LinearLayout.LayoutParams(24, 24);
        dotParams.setMarginEnd(16);
        pillLayout.addView(indicatorDot, dotParams);

        // Status text
        statusTextView = new TextView(this);
        statusTextView.setTextSize(12f);
        statusTextView.setTextColor(Color.WHITE);
        statusTextView.setText("BTmono SCO Active");
        pillLayout.addView(statusTextView);

        return pillLayout;
    }

    private void updateOverlayContent(boolean isActive) {
        if (statusTextView == null || indicatorDot == null) return;

        if (isActive) {
            statusTextView.setText("BTmono: SCO Active");
            statusTextView.setTextColor(Color.WHITE);
            GradientDrawable dot = new GradientDrawable();
            dot.setShape(GradientDrawable.OVAL);
            dot.setSize(24, 24);
            dot.setColor(Color.parseColor("#4CAF50")); // Green
            indicatorDot.setImageDrawable(dot);
        } else {
            statusTextView.setText("BTmono: Inactive");
            statusTextView.setTextColor(Color.LTGRAY);
            GradientDrawable dot = new GradientDrawable();
            dot.setShape(GradientDrawable.OVAL);
            dot.setSize(24, 24);
            dot.setColor(Color.parseColor("#9E9E9E")); // Gray
            indicatorDot.setImageDrawable(dot);
        }
    }

    private void toggleAudioRouting() {
        Intent serviceIntent = new Intent(this, BTmonoService.class);
        serviceIntent.setAction(BTmonoService.ACTION_TOGGLE);
        startService(serviceIntent);
    }

    private void hideOverlay() {
        if (isOverlayAdded && overlayView != null && windowManager != null) {
            try {
                windowManager.removeView(overlayView);
                Log.i(TAG, "Floating Camera HUD overlay removed.");
            } catch (Exception e) {
                Log.e(TAG, "Error removing overlay view: " + e.getMessage());
            } finally {
                isOverlayAdded = false;
                overlayView = null;
            }
        }
        stopSelf();
    }

    @Override
    public void onDestroy() {
        hideOverlay();
        super.onDestroy();
    }
}
