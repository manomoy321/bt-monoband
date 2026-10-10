# BTmono (2026 Modern Edition)

A ground-up architectural upgrade of the classic **BTmono** Android utility, engineered to seamlessly route all Android system audio and microphone streams to Bluetooth mono headsets (SCO / HFP) on modern Android devices (Android 5.0 Lollipop through Android 15 & 16 / API 35+).

---

## 🚀 Key Improvements & 2026 Upgrades

### 1. Modern Bluetooth Audio Engine
* **Android 12+ (API 31–35+)**: Uses the official `AudioManager.setCommunicationDevice(AudioDeviceInfo)` targeting `TYPE_BLUETOOTH_SCO` and `TYPE_BLE_HEADSET`.
* **Android 5.0–11 (API 21–30)**: Graceful fallback to `AudioManager.startBluetoothSco()` and `setBluetoothScoOn(true)` in `MODE_IN_COMMUNICATION`.
* **Auto-Discovery**: Automatically enumerates available Bluetooth communication devices and binds cleanly.

### 2. Camera App Seamless Visibility & Floating HUD
* **Floating Camera HUD Overlay (`CameraAudioOverlayService`)**:
  * An unobtrusive, draggable floating pill widget: `[ 🟢 BTmono: SCO Active ]`.
  * Remains visible on top of **any Android OS default Camera application** (Google Camera, Samsung Camera, Motorola Camera, etc.) while recording video or taking photos.
  * Allows 1-tap toggling of audio routing without closing, minimizing, or interrupting the camera viewfinder or video recording.
  * Draggable anywhere on the screen so it never covers camera controls or shutter buttons.
  * Crash-proof: gracefully checks `Settings.canDrawOverlays()` and falls back to notification/tile if overlay permission is not granted.
* **Quick Settings Tile (`BTmonoTileService`)**:
  * Adds a dedicated 1-tap Quick Settings tile to the Android status bar pull-down shade.
  * Allows users to toggle BTmono in 1 swipe down while inside any camera or third-party app.

### 3. Crash-Free Core Architecture
* **Fixed PendingIntent Crashes**: All `PendingIntent` declarations explicitly specify `FLAG_IMMUTABLE | FLAG_UPDATE_CURRENT` (required on Android 12+).
* **Fixed Foreground Service Crashes**: Compliant with Android 14+ (API 34/35) foreground service policies with `FOREGROUND_SERVICE_TYPE_CONNECTED_DEVICE`.
* **Fixed Notification Channel Bug**: Properly initializes `NotificationChannel` with `IMPORTANCE_LOW` to prevent crashes and notification silence on Android 8.0+.
* **Runtime Permissions Engine (`PermissionHelper`)**: Seamlessly requests modern runtime permissions on Android 12+ (`BLUETOOTH_CONNECT`, `BLUETOOTH_SCAN`) and Android 13+ (`POST_NOTIFICATIONS`).
* **Emergency Audio Watchdog (`CrashSafeExceptionHandler`)**: Intercepts unhandled runtime exceptions and guarantees that `AudioManager` mode is reset to `MODE_NORMAL` before app termination, preventing devices from ever being left stuck in muffled communication/call mode.
* **Clean Lifecycle Management**: Completely removed hazardous legacy calls like `Process.killProcess()`.

---

## 🛠️ Project Structure

```
btmono-modern/
  ├── app/
  │   ├── src/main/
  │   │   ├── AndroidManifest.xml
  │   │   ├── java/com/bedoig/btmono/
  │   │   │   ├── MainActivity.java
  │   │   │   ├── ModernAudioRouter.java
  │   │   │   ├── BTmonoService.java
  │   │   │   ├── BTmonoTileService.java
  │   │   │   ├── CameraAudioOverlayService.java
  │   │   │   ├── BluetoothReceiver.java
  │   │   │   ├── PermissionHelper.java
  │   │   │   ├── AppPreferences.java
  │   │   │   └── CrashSafeExceptionHandler.java
  │   │   └── res/
  │   │       ├── layout/activity_main.xml
  │   │       ├── values/ (colors, strings, styles)
  │   │       └── drawable/ (vector graphics)
  │   └── build.gradle
  ├── build.gradle
  └── settings.gradle
```

---

## 📦 Building the Application

### Option A: Via Command Line (Gradle)
```bash
gradle assembleRelease
# or debug:
gradle assembleDebug
```
The output APK will be generated at:
`app/build/outputs/apk/release/app-release.apk` (or `debug/app-debug.apk`).

### Option B: Via Android Studio
1. Open Android Studio.
2. Select **Open**, and choose `d:\Downloads\reverse enginere\btmono-modern`.
3. Click **Sync Project with Gradle Files**.
4. Click **Run** or select **Build > Build Bundle(s) / APK(s) > Build APK(s)**.
