FROM runmymind/docker-android-sdk:ubuntu-standalone

WORKDIR /

RUN git clone https://github.com/flutter/flutter.git && ln -s /flutter/bin/flutter /usr/bin/flutter

RUN apt-get update && apt-get install -y build-essential git ruby2.5-dev \
    && gem install fastlane \
    && gem install bundler \
    && gem install unf_ext -v '0.0.7.5' \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get autoremove -y && apt-get clean

RUN export PATH=$ANDROID_HOME/tools/bin:$PATH && \
    echo y | sdkmanager "tools"  && \
    echo y | sdkmanager "platform-tools"  && \
    echo y | sdkmanager "build-tools;28.0.3" && \
    echo y | sdkmanager "platforms;android-28"  && \
    echo y | sdkmanager "extras;android;m2repository"  && \
    echo y | sdkmanager "extras;google;google_play_services"  && \
    echo y | sdkmanager "extras;google;instantapps"  && \
    echo y | sdkmanager "extras;google;m2repository"  && \
    echo y | sdkmanager "extras;google;market_apk_expansion"  && \
    echo y | sdkmanager "extras;google;market_licensing"  && \
    echo y | sdkmanager "extras;google;webdriver"  && \
    echo y | sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.2"  && \
    echo y | sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2"  && \
    echo y | sdkmanager "patcher;v4" >/dev/null

RUN flutter doctor --android-licenses
RUN flutter doctor
