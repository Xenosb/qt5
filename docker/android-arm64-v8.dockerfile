FROM ubuntu:25.04

ENV DEBIAN_FRONTEND=noninteractive

ARG ANDROID_SDK_VERSION=35
ARG ANDROID_BUILD_TOOLS_VERSION=35.0.0
ARG ANDROID_NDK_VERSION=26.1.10909125
ARG QT_STABLE_VERSION=6.9.1

# Install dependencies
RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        ffmpeg \
        git \
        libclang-dev \
        libevent-dev \
        libfreetype-dev \
        libgl1-mesa-dev \
        libharfbuzz-dev \
        libicu-dev \
        libjpeg-turbo8-dev \
        liblcms2-dev \
        libminizip-dev \
        libopenjp2-7-dev \
        libopus-dev \
        libpci-dev \
        libpng-dev \
        libprotobuf-dev \
        libre2-dev \
        libssl-dev \
        libtiff-dev \
        libudev-dev \
        libvpx-dev \
        libvulkan-dev \
        libwebp-dev \
        libxcb-icccm4 \
        libxcb-image0 \
        libxcb-keysyms1 \
        libxcb-render-util0 \
        libxkbcommon-x11-0 \
        libxml2-dev \
        libxslt1-dev \
        ninja-build \
        openjdk-17-jdk \
        sdkmanager \
        wget \
        zlib1g \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Android SDK and NDK
RUN \
    sdkmanager --install \
        "tools" \
        "platform-tools" \
        "platforms;android-$ANDROID_SDK_VERSION" \
        "build-tools;$ANDROID_BUILD_TOOLS_VERSION" \
        "ndk;$ANDROID_NDK_VERSION"

# Install latest stable Qt version
RUN \
    --mount=type=secret,id=QT_EMAIL,env=QT_EMAIL \
    --mount=type=secret,id=QT_PASSWORD,env=QT_PASSWORD \
    wget https://download.qt.io/official_releases/online_installers/qt-online-installer-linux-x64-online.run && \
    chmod +x qt-online-installer-linux-x64-online.run && \
    ./qt-online-installer-linux-x64-online.run \
        install qt$QT_STABLE_VERSION-essentials-dev \
        --accept-licenses \
        --accept-obligations \
        --default-answer \
        --confirm-command \
        --email $QT_EMAIL \
        --pw $QT_PASSWORD

# Update environment variables
ENV PATH=$PATH:/opt/android-sdk/build-tools/35.0.0/:/opt/android-sdk/platform-tools:/opt/android-sdk/tools:/opt/android-sdk/tools/bin
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV ANDROID_NDK_ROOT=/opt/android-sdk/ndk/$ANDROID_NDK_VERSION

# Set default workdir
WORKDIR /workspace
