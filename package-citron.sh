#!/bin/sh
set -ex
ARCH="${ARCH:-$(uname -m)}"

# The VERSION is now passed as an environment variable from the workflow
if [ -z "$APP_VERSION" ]; then
    echo "Error: APP_VERSION environment variable is not set."
    exit 1
fi

# Construct unique names for the AppImage and tarball based on the build matrix.
OUTNAME_BASE="citron_nightly-${APP_VERSION}-linux-${ARCH}${ARCH_SUFFIX}"

SHARUN="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"
export OUTNAME="${OUTNAME_BASE}.AppImage"
export OUTPATH="$PWD"/dist
export DESKTOP=/usr/share/applications/org.citron_emu.citron.desktop
export ICON=/usr/share/icons/hicolor/scalable/apps/org.citron_emu.citron.svg
export DEPLOY_OPENGL=1
export DEPLOY_VULKAN=1
export DEPLOY_PIPEWIRE=1

if [ "$DEVEL" = 'true' ]; then
	export DEVEL_RELEASE=1
fi

wget --retry-connrefused --tries=30 "$SHARUN" -O ./quick-sharun
chmod +x ./quick-sharun
./quick-sharun /usr/bin/citron* /usr/lib/libgamemode.so*
./quick-sharun --make-appimage
