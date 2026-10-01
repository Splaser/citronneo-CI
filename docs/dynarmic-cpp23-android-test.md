# Dynarmic / C++23 Android test

This CI branch starts from Splaser/citronneo-CI main at `cfc3854`.
It does not merge upstream CI changes. macOS, Linux and Windows workflows
remain at that baseline.

Run `build-android.yml` on `codex/dynarmic-cpp23-android-test`:

```sh
gh workflow run build-android.yml --repo Splaser/citronneo-CI --ref codex/dynarmic-cpp23-android-test
```

The workflow resolves `Splaser/emulator` branch
`codex/dynarmic-latest-android-test` once, then both APK jobs check out that
exact commit. Initially this is `fa427922b3`, based on personal main
`53e5129737`, with Dynarmic pinned to `b1440b456b80f3dde0c01665932d114c4961ee93`.
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
the A32/SMU runtime regression is fixed; test the resulting APK on device.
