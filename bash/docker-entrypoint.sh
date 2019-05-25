#!/bin/bash
echo This is the command passed to docker-entrypoint.sh
echo "$@"
set -e

case $1 in
    "shell") 
        echo Launching interactive shell 
        /bin/sh
        ;;
    "emulator")
        set +e
        echo Creating emulator image Nexus
        avdmanager create avd --name Nexus --package 'system-images;android-23;default;x86_64' --device "Nexus 5" 
        echo "hw.keyboard=yes" >> $ANDROID_AVD_HOME/Nexus.avd/config.ini

        echo Launching emulator 
        $ANDROID_HOME/tools/emulator -avd Nexus
        set -e
        ;;
    "devices")
        avdmanager list device
        ;;
    "launch")
        set -e
        echo Building
        adb reverse tcp:8081 tcp:8081 
        adb reverse tcp:8097 tcp:8097
        npm install 
        set +e
        react-native eject
        react-native link react-native-gesture-handler
        set -e
        react-native run-android 
        react-native start --config=rn-cli.config.js
        /bin/sh
        ;;
    *)
        echo Your container is running.
        /bin/sh
        exec "$@"
        ;;        
esac

