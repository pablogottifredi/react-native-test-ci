#!/bin/bash

set -e

case $1 in
    "shell") 
        echo Launching interactive shell 
        sh
        ;;
    "emulator")
        set +e
        echo Creating emulator image Nexus
        avdmanager create avd --name Nexus --package 'system-images;android-23;default;x86_64' --device "Nexus 5"
        echo Launching emulator 
        emulator -avd Nexus
        set -e
        ;;
    "launch")
        set -e
        echo Building
        npm install
        
    
esac

#exec "$@"
