#!/bin/sh

set -ex
ARCH="$(uname -m)"
EXTRA_PACKAGES="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/get-debloated-pkgs.sh"

pacman -Syu --noconfirm --needed \
	base-devel          \
	boost               \
	boost-libs          \
	catch2              \
	clang               \
	cmake               \
	curl                \
	enet                \
	fmt                 \
	gamemode            \
	gcc                 \
	git                 \
	glslang             \
	glu                 \
	hidapi              \
	libvpx              \
	libxi               \
	libxkbcommon-x11    \
	libxss              \
	lld                 \
	llvm                \
	rapidjson           \
	mesa                \
	nasm                \
	ninja               \
	nlohmann-json       \
	numactl             \
	openal              \
	patchelf            \
	pulseaudio          \
	pulseaudio-alsa     \
	qt6-networkauth     \
	qt6-multimedia      \
	qt6-svg             \
	qt6-tools           \
	qt6-translations    \
	sdl2                \
	unzip               \
	vulkan-headers      \
	vulkan-mesa-layers  \
	wget                \
	xcb-util-cursor     \
	xcb-util-image      \
	xcb-util-renderutil \
	xcb-util-wm         \
	xorg-server-xvfb    \
	zip                 \
	zsync

wget --retry-connrefused --tries=30 "$EXTRA_PACKAGES" -O ./get-debloated-pkgs.sh
chmod +x ./get-debloated-pkgs.sh
./get-debloated-pkgs.sh --add-mesa ffmpeg-mini qt6-base-mini libxml2-mini opus-mini icu-mini
