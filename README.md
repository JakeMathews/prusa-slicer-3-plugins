# PrusaSlicer 3 plugins

Lua plugins for stock PrusaSlicer 3.x, the user-invoked kind that live under the
_Plugins_ menu.

| directory | what it does |
|---|---|
| [`benchy/`](benchy/) | Puts the official #3DBenchy on the plate: single-part, dual-print or multi-part. |

## Installing one

Each push to `main` publishes a signed, installable bundle as a
[GitHub release](https://github.com/JakeMathews/prusa-slicer-3-plugins/releases). Put
`jakemathews.pem` from the release into the config folder's `authorized_authors/` once,
then _Plugins → Install Plugin Bundle_ and pick the zip. Each plugin's README has the
details, plus the symlink route for working on a checkout.

## Releasing

`.github/workflows/release.yml` runs on every push to `main`. It signs the bundle with
the `PLUGIN_SIGNING_KEY` repository secret (the author's private key PEM, generated with
`PrusaSlicer plugin keygen`), checks it matches the committed public key in `keys/`, and
uploads `com.github.jakemathews.benchy.zip` and `jakemathews.pem` to a release tagged
`v<version>` from the bundle's `manifest.json`. Pushing again with the same version
replaces the assets on that release; bump the version for a new one.

To build the same zip locally:

```bash
scripts/build-bundle.sh benchy/com.github.jakemathews.benchy /path/to/jakemathews.private.pem dist
```

It uses only `openssl` and `zip` and produces the same `manifest.txt` and signature as
`PrusaSlicer plugin sign`.
