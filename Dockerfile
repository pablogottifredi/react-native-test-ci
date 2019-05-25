FROM ubuntu:18.04

RUN apt-get update

# Install Android SDK
## Dependencies
RUN apt-get install -y unzip curl ca-certificates openjdk-8-jdk
ENV JAVA8_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV JAVA_HOME $JAVA8_HOME

## SDK tools
ENV ANDROID_HOME /opt/android-sdk-linux 
ARG VERSION_SDK_TOOLS=4333796
ENV ANDROID_SDK_ZIP http://dl.google.com/android/repository/sdk-tools-linux-$VERSION_SDK_TOOLS.zip

RUN mkdir -p $ANDROID_HOME && curl -L $ANDROID_SDK_ZIP --output sdk.zip && unzip sdk.zip -d $ANDROID_HOME && rm sdk.zip

ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

RUN mkdir -p /root/.android && touch /root/.android/repositories.cfg

RUN yes | sdkmanager --verbose 'platform-tools'
RUN yes | sdkmanager --verbose 'emulator'
RUN yes | sdkmanager --verbose 'extras;android;m2repository'
RUN yes | sdkmanager --verbose 'extras;google;google_play_services'
RUN yes | sdkmanager --verbose 'extras;google;m2repository'
RUN yes | sdkmanager --verbose 'build-tools;23.0.1'
RUN yes | sdkmanager --verbose 'platforms;android-23'
RUN yes | sdkmanager --verbose 'system-images;android-23;default;x86_64'

RUN yes | sdkmanager --update --verbose
RUN yes | sdkmanager --licenses
# Done installing Android SDK


# Set up React Native
## Install node, yarn, and react-native-cli
RUN apt-get install -y git libssl-dev autoconf automake libtool python-dev pkg-config

RUN apt-get install -y nodejs
RUN apt-get install -y npm
RUN npm install -g react-native-cli
RUN apt-get install -y yarn 


RUN git clone https://github.com/facebook/watchman.git \
&& cd watchman \
&& git checkout v4.9.0 \
&& ./autogen.sh \
&& ./configure \
&& make \
&& make install \
&& cd .. \
&& rm -rf watchman
RUN watchman --version 


ARG USERNAME=dev
ARG UID=1000

RUN useradd -ms /bin/bash $USERNAME
RUN usermod -aG sudo $USERNAME

ENV XDG_RUNTIME_DIR /run/user/$UID
RUN mkdir -p $XDG_RUNTIME_DIR && chown -R $USERNAME:$USERNAME $XDG_RUNTIME_DIR


RUN apt install -y cpu-checker
RUN apt install -y qemu-kvm 

COPY bash/docker-entrypoint.sh /usr/local/bin/

ARG USER_BIN_DIR=/home/$USERNAME/.bin
RUN mkdir $USER_BIN_DIR && echo '(cd "$ANDROID_HOME"/tools && ./emulator "$@")'  >> $USER_BIN_DIR/emulator 
ENV PATH $USER_BIN_DIR:$PATH

COPY src /project

ENV PATH $YARN_PATH:$PATH

ENV PROJECT_MOUNT=/project
WORKDIR $PROJECT_MOUNT

ENV GRADLE_USER_HOME $PROJECT_MOUNT/android/gradle_deps
RUN alias emulator=${ANDROID_HOME}/emulator/emulator


ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
EXPOSE 8081

CMD ["sleep", "infinity"]


