FROM ubuntu:20.04

RUN apt-get update && \
  apt-get install -y wget \
    openjdk-8-jre-headless=8u275-b01-0ubuntu1~20.04 \
    openjdk-8-jdk-headless=8u275-b01-0ubuntu1~20.04 \
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
  rm -f *.zip && \
  ln -s /opt/android-sdk/cmdline-tools/tools/bin/sdkmanager /usr/bin/sdkmanager && \
  yes | sdkmanager --licenses && \
  sdkmanager "build-tools;29.0.3" && \
  ln -s /opt/android-sdk/build-tools/29.0.3/apksigner /usr/bin/apksigner && \
  wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool && \
  wget https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.4.1.jar && \
  mv *.jar apktool.jar && \
  mv apktool apktool.jar /usr/local/bin/ && \
  chmod +x /usr/local/bin/apktool /usr/local/bin/apktool.jar
# following https://github.com/Microsoft/vscode-arduino/issues/644#issuecomment-415329398
RUN rm /etc/java-8-openjdk/accessibility.properties
