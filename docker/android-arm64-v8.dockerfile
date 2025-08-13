FROM ubuntu:25.04

ENV DEBIAN_FRONTEND=noninteractive

ARG ANDROID_SDK_VERSION=35
ARG ANDROID_BUILD_TOOLS_VERSION=35.0.0
ARG ANDROID_NDK_VERSION=26.1.10909125

# Install dependencies
RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        ffmpeg \
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
        libxml2-dev \
        libxslt1-dev \
        openjdk-17-jdk \
        sdkmanager \
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

# Set default workdir
WORKDIR /workspace
