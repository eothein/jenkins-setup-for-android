#!/bin/bash

while [ ! -f /var/lib/cloud/instance/boot-finished ];
    do echo 'Waiting for cloud-init...';
    sleep 1;
done

sudo apt-get update
sudo apt-get install -y default-jdk
sudo apt-get install unzip

#Install the android sdk
wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
mkdir android-sdk
unzip sdk-tools-linux-4333796.zip -d android-sdk
# Accept the licenses for android-sdk
yes | android-sdk/tools/bin/sdkmanager --licenses

export ANDROID_HOME=`pwd`/android-sdk
export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"

#To fix problem with update: https://askubuntu.com/questions/885658/android-sdk-repositories-cfg-could-not-be-loaded

touch ~/.android/repositories.cfg
echo "### User Sources for Android SDK Manager #Fri Nov 03 10:11:27 CET 2017 count=0" > ~/.android/repositories.cfg

sudo chown -R jenkins /tmp
sudo chmod -R g+wr /tmp

