package com.bedoig.btmono;

import android.bluetooth.BluetoothAdapter;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.media.AudioManager;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.SeekBar;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.SwitchCompat;
import androidx.core.content.ContextCompat;

import com.google.android.material.button.MaterialButton;
import com.google.android.material.card.MaterialCardView;

public class MainActivity extends AppCompatActivity {

    private static final String TAG = "MainActivity";

    private MaterialButton btnToggle;
    private TextView tvStatusTitle;
    private TextView tvStatusSubtitle;
    private TextView tvDiagnostics;
    private ImageView ivStatusIcon;
    private SeekBar seekbarVolume;
    private SwitchCompat switchCameraOverlay;
    private SwitchCompat switchAutoOn;
    private MaterialCardView cardDiagnostics;

    private AudioManager audioManager;
    private ModernAudioRouter audioRouter;
    private AppPreferences preferences;

    private boolean isServiceActive = false;
    private final Handler uiHandler = new Handler(Looper.getMainLooper());

    private final BroadcastReceiver statusReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            if (intent != null && BTmonoService.ACTION_STATUS_BROADCAST.equals(intent.getAction())) {
                boolean isRouting = intent.getBooleanExtra(BTmonoService.EXTRA_IS_ROUTING, false);
                updateUiState(isRouting);
            }
        }
    };

    @Override
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        CrashSafeExceptionHandler.install(this);
        setContentView(R.layout.activity_main);

        preferences = new AppPreferences(this);
        audioManager = (AudioManager) getSystemService(Context.AUDIO_SERVICE);
        audioRouter = new ModernAudioRouter(this);

        initViews();
        setupListeners();

        // Check & request modern runtime permissions
        PermissionHelper.requestRequiredPermissions(this);

        // Auto-on preference check
        if (preferences.isAutoOn() && !isServiceActive) {
            startAudioService();
        }
    }

    private void initViews() {
        btnToggle = findViewById(R.id.btnToggle);
        tvStatusTitle = findViewById(R.id.tvStatusTitle);
        tvStatusSubtitle = findViewById(R.id.tvStatusSubtitle);
        tvDiagnostics = findViewById(R.id.tvDiagnostics);
        ivStatusIcon = findViewById(R.id.ivStatusIcon);
        seekbarVolume = findViewById(R.id.seekbarVolume);
        switchCameraOverlay = findViewById(R.id.switchCameraOverlay);
        switchAutoOn = findViewById(R.id.switchAutoOn);
        cardDiagnostics = findViewById(R.id.cardDiagnostics);

        // Setup Volume bar
        if (audioManager != null) {
            int maxVol = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC);
            int currentVol = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC);
            seekbarVolume.setMax(maxVol);
            seekbarVolume.setProgress(currentVol);
        }

        switchAutoOn.setChecked(preferences.isAutoOn());
        switchCameraOverlay.setChecked(preferences.isCameraOverlayEnabled());

        updateUiState(false);
    }

    private void setupListeners() {
        btnToggle.setOnClickListener(v -> {
            if (!PermissionHelper.hasBluetoothPermissions(this)) {
                PermissionHelper.requestRequiredPermissions(this);
                Toast.makeText(this, "Bluetooth permissions required to connect.", Toast.LENGTH_SHORT).show();
                return;
            }

            if (isServiceActive) {
                stopAudioService();
            } else {
                startAudioService();
            }
        });

        seekbarVolume.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                if (fromUser && audioManager != null) {
                    audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, progress, 0);
                    preferences.setLastVolume(progress);
                }
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {}

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {}
        });

        switchAutoOn.setOnCheckedChangeListener((buttonView, isChecked) -> {
            preferences.setAutoOn(isChecked);
        });

        switchCameraOverlay.setOnCheckedChangeListener((buttonView, isChecked) -> {
            preferences.setCameraOverlayEnabled(isChecked);
            if (isChecked && !PermissionHelper.canDrawOverlays(this)) {
                PermissionHelper.requestOverlayPermission(this);
            }
        });
    }

    private void startAudioService() {
        Intent serviceIntent = new Intent(this, BTmonoService.class);
        serviceIntent.setAction(BTmonoService.ACTION_START);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            ContextCompat.startForegroundService(this, serviceIntent);
        } else {
            startService(serviceIntent);
        }
        updateUiState(true);
    }

    private void stopAudioService() {
        Intent serviceIntent = new Intent(this, BTmonoService.class);
        serviceIntent.setAction(BTmonoService.ACTION_STOP);
        startService(serviceIntent);
        updateUiState(false);
    }

    private void updateUiState(boolean active) {
        isServiceActive = active;

        if (active) {
            btnToggle.setText("STOP ROUTING");
            btnToggle.setBackgroundColor(getColor(R.color.color_accent_stop));
            tvStatusTitle.setText("ROUTING ACTIVE");
            tvStatusSubtitle.setText("Audio sent to Bluetooth SCO mono channel");
            ivStatusIcon.setImageResource(R.drawable.ic_bt_active);
        } else {
            btnToggle.setText("START ROUTING");
            btnToggle.setBackgroundColor(getColor(R.color.color_primary_brand));
            tvStatusTitle.setText("STANDBY");
            tvStatusSubtitle.setText("Tap to route media & microphone to Bluetooth");
            ivStatusIcon.setImageResource(R.drawable.ic_bt_inactive);
        }

        // Live diagnostics string
        if (tvDiagnostics != null && audioRouter != null) {
            tvDiagnostics.setText(audioRouter.getStatusSummary());
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        IntentFilter filter = new IntentFilter(BTmonoService.ACTION_STATUS_BROADCAST);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            registerReceiver(statusReceiver, filter, Context.RECEIVER_NOT_EXPORTED);
        } else {
            registerReceiver(statusReceiver, filter);
        }

        // Sync volume seekbar with system volume
        if (audioManager != null && seekbarVolume != null) {
            seekbarVolume.setProgress(audioManager.getStreamVolume(AudioManager.STREAM_MUSIC));
        }

        if (audioRouter != null && tvDiagnostics != null) {
            tvDiagnostics.setText(audioRouter.getStatusSummary());
        }
    }

    @Override
    protected void onPause() {
        try {
            unregisterReceiver(statusReceiver);
        } catch (Exception ignored) {}
        super.onPause();
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == PermissionHelper.REQUEST_CODE_PERMISSIONS) {
            boolean allGranted = true;
            for (int res : grantResults) {
                if (res != PackageManager.PERMISSION_GRANTED) {
                    allGranted = false;
                    break;
                }
            }
            if (allGranted) {
                Toast.makeText(this, "Permissions granted! Ready to route audio.", Toast.LENGTH_SHORT).show();
            } else {
                Toast.makeText(this, "Bluetooth permissions are required for audio routing.", Toast.LENGTH_LONG).show();
            }
        }
    }
}
