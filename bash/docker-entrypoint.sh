#!/bin/bash
echo Command passed to docker-entrypoint.sh
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
        echo Launching emulator 
        $ANDROID_HOME/tools/emulator -avd Nexus
        set -e
        ;;
    "launch")
        set -e
        echo Building
        adb reverse tcp:8081 tcp:8081 
        yarn install --production=false
        set +e
        yarn react-native eject
        set -e
        yarn react-native run-android
         /bin/sh
        ;;
    *)
        echo Your container is running.
        /bin/sh
        exec "$@"
        ;;        
esac

