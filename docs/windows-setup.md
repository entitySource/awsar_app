# Set up Flutter and Android Studio on Windows

Takes about 30 to 60 minutes, mostly downloads. You need roughly 15 GB of free disk space.

## 1. Install Git

Download it from https://git-scm.com/download/win and install with the default options. Flutter needs Git.

## 2. Install Flutter

1. Download the latest **stable** Flutter SDK zip for Windows from https://docs.flutter.dev/get-started/install/windows/mobile
2. Extract it to `C:\dev\flutter`. Avoid paths with spaces, and don't use `C:\Program Files`.
3. Add Flutter to your PATH:
   1. Press Start, type **environment variables**, and open "Edit environment variables for your account".
   2. Select **Path**, click **Edit**, then **New**, and add `C:\dev\flutter\bin`.
   3. Click OK on each window.
4. Open a **new** PowerShell window and check:

```powershell
flutter --version
```

The app needs Flutter **3.47 or newer**, which comes with Dart 3.13. If yours is older, run `flutter upgrade`.

## 3. Install Android Studio

1. Download it from https://developer.android.com/studio and install with the defaults.
2. On first launch, choose **Standard** in the setup wizard. This downloads the Android SDK, platform tools and an emulator.
3. Go to **More Actions → SDK Manager → SDK Tools** and tick **Android SDK Command-line Tools (latest)**, then click Apply.
4. Go to **Plugins** and install **Flutter**, which also installs Dart. Restart Android Studio.

## 4. Accept licences and check everything

```powershell
flutter doctor --android-licenses   # press y for each one
flutter doctor
```

You want green ticks for **Flutter**, **Android toolchain** and **Android Studio**. A warning about **Visual Studio** only matters for Windows desktop apps, so you can ignore it.

## 5. Get a device to run on

**Your Android phone (recommended for the demo)**

1. On the phone, go to **Settings → About phone** and tap **Build number** 7 times to unlock developer options.
2. Go to **Settings → Developer options** and turn on **USB debugging**.
3. Plug the phone into the laptop and tap **Allow** on the phone's prompt.
4. Run `flutter devices`. Your phone should be listed.

**Or an emulator:** in Android Studio, open **Device Manager → Create device**, pick a Pixel with the latest system image, then press Play.

## 6. Run the AWSAR app

```powershell
cd C:\dev
Expand-Archive awsar-app-kit.zip -DestinationPath C:\dev
cd C:\dev\awsar-app\awsar_app
flutter pub get
flutter run --dart-define-from-file=supabase.json
```

The first Android build takes 5 to 15 minutes while Gradle downloads its files. Later builds are much faster.

Build an APK to install or share:

```powershell
flutter build apk --release --dart-define-from-file=supabase.json
```

The APK is saved at `build\app\outputs\flutter-apk\app-release.apk`.

(Without `supabase.json`, leave off `--dart-define-from-file=...`. The app still works, but login stays off.)

## If something goes wrong

| Problem | Fix |
|---|---|
| `flutter` is not recognized | PATH wasn't saved, or the window is old. Check step 2.3, then open a new PowerShell window. |
| Unable to locate Android SDK | `flutter config --android-sdk "$env:LOCALAPPDATA\Android\Sdk"` |
| cmdline-tools component is missing | Do step 3.3, then run `flutter doctor --android-licenses` again. |
| Java / JDK version error | `flutter config --jdk-dir "C:\Program Files\Android\Android Studio\jbr"` |
| Phone not listed in `flutter devices` | Try another USB cable or port, set USB mode to **File transfer**, and accept the debugging prompt on the phone. |
| Build fails partway through | `flutter clean`, then `flutter pub get`, then run again. |
| Android SDK location contains spaces | Close Android Studio, move the SDK to `C:\dev\Android\Sdk`, run `flutter config --android-sdk C:\dev\Android\Sdk`, and set the same path in SDK Manager → Android SDK Location. |
| sdkmanager did not install NDK 28.2.13676358 | SDK Manager → SDK Tools → tick **Show Package Details** → NDK (Side by side) → 28.2.13676358, plus CMake. Apply, then run again. |
| `INSTALL_FAILED_USER_RESTRICTED` (Xiaomi/Redmi/POCO) | Developer options → turn on **Install via USB** (needs a Mi account), then tap Install on the phone's prompt. Or copy `build\app\outputs\flutter-apk\app-debug.apk` to the phone and open it. |
