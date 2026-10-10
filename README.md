# BT-Mono (`bt-monoband`) 🎙️🎧 — Bluetooth Headphone Mic for Default Camera & Mono Audio Router

[![Android Compatibility](https://img.shields.io/badge/Android-5.0_to_16+_(API_21--35+)-3DDC84?logo=android&logoColor=white)](https://github.com/manomoy321/bt-monoband)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/manomoy321/bt-monoband/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/badge/Release-v2026.1_BT--Mono-brightgreen)](https://github.com/manomoy321/bt-monoband/releases/tag/v2026.1)
[![Download BT-Mono APK](https://img.shields.io/badge/Download-BT--Mono.apk-blue?logo=android)](https://github.com/manomoy321/bt-monoband/releases/download/v2026.1/BT-Mono.apk)
[![Zero Ads](https://img.shields.io/badge/Ads-Completely_Removed-success)](#)
[![No Paywalls](https://img.shields.io/badge/Premium-100%25_Free-orange)](#)

> **Use your Bluetooth headphone or earbuds as an external wireless microphone in your phone's default camera app all the time.**  
> Includes hardware SCO mic lock, active audio keep-alive, media routing, zero ads, and 100% free unlocked features for Android 5.0 through 15 & 16+.

---

## 📥 Direct Download (BT-Mono APK)

* 🚀 **[Direct Download: BT-Mono.apk (v2026.1 Production Build)](https://github.com/manomoy321/bt-monoband/releases/download/v2026.1/BT-Mono.apk)** *(2.23 MiB — Signed with v1, v2, v3 schemes, valid through 2054)*
* 📦 **[View GitHub Release v2026.1](https://github.com/manomoy321/bt-monoband/releases/tag/v2026.1)**
* 📁 **[Download Directly from Repository Tree](https://github.com/manomoy321/bt-monoband/raw/main/BT-Mono.apk)**

---

## 🎙️ Primary Purpose: Bluetooth Mic for Default Camera Video Recording

By default, stock Android camera apps (including Samsung Camera, Google Pixel Camera, Xiaomi, etc.) **ignore connected Bluetooth headphones** when filming video, forcing audio recording through the phone's built-in phone body microphones.

### How BT-Mono Fixes This:
1. **Hardware SCO Mic Lock**: `BT-Mono` initiates a bidirectional Bluetooth SCO link with `MODE_IN_COMMUNICATION` and an active `AudioRecord` background stream. This prevents the Android Audio HAL from powering down or dropping the Bluetooth microphone when you switch to your camera.
2. **Auto-Granted Runtime Permissions**: Prompts for `RECORD_AUDIO` and `BLUETOOTH_CONNECT` upon opening, eliminating silent permission blocks on modern Android versions.
3. **Works While Filming Video**: Keep `BT-Mono` turned **On**, open your phone's default Camera app, and begin recording video — audio is captured directly from your wireless headset.

> **💡 Samsung Galaxy Camera Tip (One UI 5 / 6 / 7)**:
> In the Samsung Camera app, you can also swipe to **Pro Video** mode: tap the **MIC** button at the bottom and select **BT** (Bluetooth) for high-definition studio microphone capture!

---

## 🔍 Why BT-Mono? (Overview & Problem Solved)

By default, the Android operating system only routes phone calls through mono Bluetooth headsets (using the Bluetooth SCO / Hands-Free Profile - HFP). Regular media audio (music, YouTube, GPS turn-by-turn directions, social media audio) is restricted to stereo A2DP devices or played through the phone's built-in speaker.

**BT-Mono bridges this gap** by forcing media audio streams through the Bluetooth SCO channel.

### What Makes This 2026 Upgraded Edition Better?
* **Bluetooth Headphone as Wireless Camera Mic**: Fixes the missing recording stream so your Bluetooth mic works with camera video.
* **100% Free Forever**: All previous in-app paywalls, donation prompts, and AdMob tracking have been permanently removed.
* **All Color Themes & Features Unlocked**: Access all 9 custom status color themes and the *"Restart After Call"* automation toggle for free.
* **Android 14, 15 & 16 Compatible**: Overcomes Google's minimum SDK deprecation block (`INSTALL_FAILED_DEPRECATED_SDK_VERSION`) and Samsung One UI 6+ installation restrictions.
* **Visible Over Default Camera Apps**: Includes a floating, draggable HUD pill and a Quick Settings pull-down tile so you can monitor audio status and toggle routing while recording video in your camera app.
* **Crash-Safe Audio Watchdog**: Automatically restores device audio mode from `MODE_IN_COMMUNICATION` to `MODE_NORMAL` if Bluetooth disconnects or if an unexpected error occurs, ensuring your phone's speaker and microphone never get stuck in muffled call mode.

---

## ⚡ Comparison: Original 2012 App vs. 2026 Upgraded Edition

| Feature | Original BTmono (2012) | BTmono 2026 Upgraded (`bt-monoband`) |
| :--- | :--- | :--- |
| **Android Version Support** | Android 2.2 – 4.0 (Crashes on Android 8+) | **Android 5.0 through Android 15 & 16+** |
| **Target SDK** | API 14 (Blocked on Android 14+) | **API 28 / API 35 Modernized Architecture** |
| **Monetization & Ads** | AdMob banner ads + Paid premium tier | **100% Free & Open Source (Zero Ads)** |
| **Premium Features** | Locked behind payment | **Fully Unlocked** (All 9 color themes + Restart After Call) |
| **Android 12+ PendingIntents** | Crash (`IllegalArgumentException`) | **Fixed with `FLAG_IMMUTABLE`** |
| **Android 8+ Notifications** | Missing notification channels | **Fixed with low-importance persistent channel** |
| **Android 14+ Service Types** | Crash (`MissingForegroundServiceType`) | **Passed `connectedDevice` foreground service type** |
| **Camera App Integration** | None (Minimizes camera to open app) | **Floating Draggable HUD Pill + Quick Settings Tile** |
| **Audio Routing Engine** | Deprecated `startBluetoothSco()` only | **Dual Engine: Legacy SCO + Modern `setCommunicationDevice`** |
| **Uncaught Crash Recovery** | System audio stays stuck in call mode | **Automatic Watchdog Teardown Guard** |

---

## 🛠️ How to Install (Including Samsung Galaxy Devices)

### Step 1: Remove Old Version
If you have any older version of BTmono installed from the Google Play Store or APK mirrors, **uninstall it first**. Android will prevent installing an updated APK if the signing signature differs (`INSTALL_FAILED_UPDATE_INCOMPATIBLE`).

### Step 2: Samsung Galaxy Auto Blocker Notice (One UI 6 / 6.1 / 7)
Samsung devices running Android 14 or 15 feature an automated security setting called **Auto Blocker** that blocks sideloading apps by default:
1. Open phone **Settings**.
2. Scroll to **Security and privacy** ➡️ **Auto Blocker**.
3. Temporarily switch **Auto Blocker** to **Off**.
4. Open the downloaded [BTmono-2026-Upgraded.apk](BTmono-2026-Upgraded.apk) and tap **Install**.
*(You can re-enable Auto Blocker after installation is complete).*

### Step 3: Install via ADB (Optional for Developers)
```bash
adb install -r BTmono-2026-Upgraded.apk
```

---

## 📱 Features & Highlights

### 1. 1-Tap Quick Audio Routing
Tap **Turn On** to immediately activate Bluetooth SCO routing. Media volume slider gives you direct control over your headset volume.

### 2. Camera Overlay HUD for Video Recording
Want to use your Bluetooth mono earpiece or wireless microphone while recording video in your phone's default Camera app?
* A compact, unobtrusive floating pill sits on top of any camera interface.
* Displays live state: `[ 🟢 BTmono: SCO Active ]` or `[ ⚪ BTmono: Inactive ]`.
* Smooth touch-and-drag allows you to position it anywhere without blocking your camera viewfinder or shutter button.
* 1-tap toggling directly from the viewfinder.

### 3. Quick Settings Status Bar Tile
Pull down your notification tray from any screen or inside any app to toggle BTmono with a single tap.

### 4. Custom Themes & Unlocked Preferences
* **Restart After Call**: Seamlessly resumes mono routing once you finish a cellular call.
* **Color Themes**: Choose between Classic, Red, Cyan, Yellow, Green, Purple, Pink, Lime, and Orange.

---

## 📂 Repository Contents

```
bt-monoband/
├── BTmono-2026-Upgraded.apk     # Pre-built, signed, and aligned production APK (v2026.1)
├── btmono-release.keystore      # Dedicated RSA-2048 release signing keystore (Valid to 2054)
├── btmono-modern/               # Modern Android Studio & Gradle project (Java 17, Target SDK 35)
│   ├── app/src/main/java/com/bedoig/btmono/
│   │   ├── ModernAudioRouter.java          # AudioDeviceInfo & SCO communication router
│   │   ├── CameraAudioOverlayService.java  # Draggable floating camera overlay HUD
│   │   ├── BTmonoTileService.java          # Android Quick Settings status bar tile
│   │   ├── BluetoothReceiver.java          # ACL connection state watchdog
│   │   ├── CrashSafeExceptionHandler.java  # Uncaught exception audio cleanup guard
│   │   ├── PermissionHelper.java           # Android 12-15 runtime permissions
│   │   └── MainActivity.java               # Modern Material Design 3 dashboard
│   └── build.gradle.kts
└── btmono-apktool/              # Fully decompiled, patched smali & unlocked resources
    ├── AndroidManifest.xml      # Updated with exported attributes, permissions & SDK 28
    ├── res/layout/main.xml      # Modern dark slate layout (#0f172a) without AdMob
    ├── res/xml/preferences.xml  # Unlocked settings screen
    └── smali/                   # Cleaned smali bytecode with immutable PendingIntents
```

---

## ❓ Frequently Asked Questions (FAQ)

### Can I listen to music or YouTube on a mono Bluetooth headset?
Yes! Standard Android devices do not stream media audio to mono headsets or single-ear Bluetooth earpieces. BTmono redirects the media stream through the SCO audio channel, enabling full music, navigation, and podcast playback.

### Why does the camera app need BTmono?
Most default camera applications do not support Bluetooth microphones for video recording. By activating BTmono, your phone's system audio input and output are coupled to the Bluetooth SCO device, allowing you to use your wireless headset as an external wireless microphone while recording.

### Is this application completely free?
Yes. The original application had paid restrictions and third-party advertising. This repository provides a completely open, modernized, zero-ad, and 100% unlocked version for the community.

---

## 📄 License
This project is released as open source under the MIT License for educational and accessibility purposes.

---

### 🏷️ SEO & Search Keywords
`btmono apk download` · `bt mono band` · `bluetooth mono audio router android` · `stream music to bluetooth earpiece` · `android bluetooth sco audio` · `bluetooth mic for default camera android` · `samsung one ui btmono apk` · `btmono android 14 15 16` · `free open source btmono`
