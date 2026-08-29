#!/bin/bash
# Installs just enough Android SDK to build a Capacitor app's debug APK.
# Runs once automatically when the Codespace is first created.
set -e
echo "Setting up Android SDK (this takes a few minutes, only happens once)..."

ANDROID_HOME="$HOME/android-sdk"
mkdir -p "$ANDROID_HOME/cmdline-tools"
cd "$ANDROID_HOME/cmdline-tools"

curl -s -o cmdtools.zip https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
unzip -q cmdtools.zip
mv cmdline-tools latest
rm cmdtools.zip

echo "export ANDROID_HOME=$ANDROID_HOME" >> ~/.bashrc
echo "export PATH=\$PATH:\$ANDROID_HOME/cmdline-tools/latest/bin:\$ANDROID_HOME/platform-tools" >> ~/.bashrc

export ANDROID_HOME="$ANDROID_HOME"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"

yes | sdkmanager --licenses > /dev/null 2>&1 || true
sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"

echo "Android SDK ready."
