FROM ubuntu:19.10

RUN apt-get update && \
  apt-get install -y wget \
    openjdk-8-jre-headless=8u252-b09-1~19.10 \
    openjdk-8-jdk-headless=8u252-b09-1~19.10 \
    git unzip && \
  rm -rf /var/lib/apt/lists/* && \
  apt-get autoremove -y && \
  apt-get clean

# download and install Android SDK
ENV ANDROID_HOME /opt/android-sdk
RUN mkdir -p /opt/android-sdk/cmdline-tools && \
  cd /opt/android-sdk/cmdline-tools && \
  wget -q https://dl.google.com/android/repository/commandlinetools-linux-6514223_latest.zip && \
  unzip *.zip && \
  yes | /opt/android-sdk/cmdline-tools/tools/bin/sdkmanager --licenses && \
  /opt/android-sdk/cmdline-tools/tools/bin/sdkmanager "build-tools;28.0.3"
