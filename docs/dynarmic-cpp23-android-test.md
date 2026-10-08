# CPM / C++23 Android nightly

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

## Android nightly publishing

The user has validated the CPM / C++23 Android builds on-device. The Android
workflow now publishes `nightly-android` after both APK variants succeed. It runs
daily at 00:17 UTC (08:17 Asia/Taipei) and can be dispatched manually:

```sh
gh workflow run build-android.yml --repo Splaser/citronneo-CI --ref main
```

The full emulator commit recorded in the release body is the build marker.
An unchanged, already-published source commit is skipped. A missing release or
a failed previous build is retried; there is no shared desktop version-file update.
Use `-f force_build=true` to rebuild and publish the same source revision, or
`-f build_only=true` to force both APK builds without publishing.

Artifacts are `citron-android-nightly` and `citron-android-8elite`. Both APKs are
validated before replacing the previous nightly release. No Discord messages
are sent. Only dispatches from CI `main` can build or publish.

## Paused desktop workflows

The standalone Windows, Linux and macOS workflows and the old all-platform
Nightly / Stable workflows are disabled in GitHub Actions. Their source
configurations remain unchanged. Re-enable them explicitly before dispatching;
the Android nightly workflow does not invoke any desktop jobs.
