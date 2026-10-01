# Dynarmic / C++23 Android test

These workflows were developed from Splaser/citronneo-CI main at `cfc3854`
and are now synchronized to main alongside the emulator changes.
It does not merge upstream CI changes. macOS remains at that baseline;
Windows and Linux have independent provider test workflows on main.

Run `build-android.yml` on `main`:

```sh
gh workflow run build-android.yml --repo Splaser/citronneo-CI --ref main
```

The workflow resolves `Splaser/emulator` branch
`main` once, then both APK jobs check out that
exact commit from personal main, with Dynarmic pinned to
`b1440b456b80f3dde0c01665932d114c4961ee93`.
Source submodules remain uninitialized; dependencies use CPM.

Both jobs install [NDK r29](https://github.com/android/ndk/releases/tag/r29)
(`29.0.14206865`) and update the cloned Gradle `ndkVersion` to match.
An ARM64/API 30 compile-and-link probe checks `std::format` and `std::print`
before starting Gradle. Emulator sources retain C++23 and native standard
formatting. ccache keys include the NDK version.

Every manual run builds both APK variants and uploads:

- `citron-android-dynarmic-cpp23`
- `citron-android-8elite-dynarmic-cpp23`

There is no release job, version-file update, or Discord notification in
this test workflow. Successful APK compilation does not establish that
the A32/SMU runtime regression is fixed. The user has confirmed that SMU starts
successfully with the current baseline; longer gameplay remains separate coverage.

Windows and Linux run independently from Android, with separate concurrency
keys. Each resolves personal main once, or accepts an optional 40-character
`source_commit` input to test an exact emulator revision:

- `build-windows.yml`: Windows/MSVC, vcpkg plus source submodules.
- `build-linux.yml`: Linux/GCC, system packages plus source submodules
  (versions recorded in the log).

Both build the SDL CLI, shader tool and tests with Qt disabled. They do not prove
Qt packaging or desktop CPM support. Dispatch each platform independently on CI `main`:

```sh
gh workflow run build-windows.yml --repo Splaser/citronneo-CI --ref main
gh workflow run build-linux.yml --repo Splaser/citronneo-CI --ref main
```

For a comparison using the same source revision, add `-f source_commit=<full-SHA>`
to each desktop command. Android resolves its source revision separately and
prints it in the log. Starting or cancelling one platform does not affect another.
All three test workflows only upload build artifacts; they do not publish releases,
update version files, or send Discord notifications. All three workflows build Splaser/emulator `main` by default.
