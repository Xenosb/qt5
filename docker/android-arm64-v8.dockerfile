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
# RUN \
#     --mount=type=secret,id=QT_USERNAME,env=QT_USERNAME \
#     --mount=type=secret,id=QT_PASSWORD,env=QT_PASSWORD \
#     wget https://download.qt.io/official_releases/online_installers/qt-online-installer-linux-x64-online.run && \
#     chmod +x qt-online-installer-linux-x64-online.run && \
#     ./qt-online-installer-linux-x64-online.run \
#         --accept-licenses \
#         --accept-obligations \
#         --default-answer \
#         --confirm-command \
#         --email $QT_EMAIL \
#         --pw $QT_PASSWORD \
#         install qt$QT_STABLE_VERSION-essentials-dev

# Set default workdir
WORKDIR /workspace
