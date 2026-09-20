# Benchy — a PrusaSlicer 3 plugin

A `project.plugin` bundle for stock PrusaSlicer 3.x. It adds a _Plugins → Benchy_
submenu that puts the official #3DBenchy on the selected bed, in any of the three forms
the official repository ships:

| menu item | what you get |
|---|---|
| **Single-part** | The classic `3DBenchy.stl`, one solid object. |
| **Dual-print (2 parts)** | One object, two parts: hull and deck. The dialog asks which extruder each gets, so it slices two-colour immediately on a multi-material printer. |
| **Multi-part (17 parts)** | One object made of the 17 individually named parts, so each can get its own extruder, colour or settings in the object list. |

## Why the STL is bundled

The plugin runtime is deliberately sandboxed: no `os`, no `io`, no network, and
`load_stl` may only read files that sit in the same directory as the plugin's `.lua`.
So the plugin cannot download anything. Instead the unmodified STLs from
<https://github.com/CreativeTools/3DBenchy> live inside the bundle, next to the Lua
files, renamed to something `load_stl` can be handed without a `#` in it.

#3DBenchy is released under CC0 1.0, and its licence page explicitly permits
redistribution "including it in software distributions". Details, source commit and
checksum are in [`com.github.jakemathews.benchy/3DBenchy-LICENSE.md`](com.github.jakemathews.benchy/3DBenchy-LICENSE.md).

To refresh the STLs from the official archive:

```bash
./fetch-benchy.sh
```

## Installing

### From a release (recommended)

Every push to `main` publishes a signed bundle on the
[releases page](https://github.com/JakeMathews/prusa-slicer-3-plugins/releases). PrusaSlicer
only installs bundles whose author it already trusts, so the first install is two steps:

1. Download `jakemathews.pem` from the release and put it in the `authorized_authors/`
   folder inside PrusaSlicer's configuration folder (_Help → Show Configuration Folder_;
   on macOS that is `~/Library/Application Support/PrusaSlicer3-dev/authorized_authors/`).
   This is a one-time step; it trusts every bundle signed with that key.
2. In PrusaSlicer, _Plugins → Install Plugin Bundle_ and pick
   `com.github.jakemathews.benchy.zip`.

Later releases only need step 2. The plugin lands in the `lua/` folder next to
`authorized_authors/` and replaces any previous copy.

### From a checkout (for hacking on it)

Symlink the bundle directory, **named exactly as the `id` in `manifest.json`**, into the
configuration folder's `lua/`, then _Plugins → Rescan Plugins_.

macOS:

```bash
mkdir -p "$HOME/Library/Application Support/PrusaSlicer3-dev/lua"
ln -sfn "$PWD/com.github.jakemathews.benchy" "$HOME/Library/Application Support/PrusaSlicer3-dev/lua/"
```

Linux:

```bash
mkdir -p ~/.config/PrusaSlicer3-dev/lua
ln -sfn "$PWD/com.github.jakemathews.benchy" ~/.config/PrusaSlicer3-dev/lua/
```

`PrusaSlicer3-dev` is the config directory the 3.0 alpha builds use. If yours differs,
_Help → Show Configuration Folder_ shows the right one.

## Using it

_Plugins → Benchy → …_. The slicer always opens a dialog before running a project
plugin, so the single-part and multi-part items show just a _Run_ button; the
dual-print item also asks for the hull and deck extruder numbers. The Benchy lands
hull down, centred on the currently selected bed. Run it again for another one and let
_Arrange_ spread them out.

## Licence

The plugin code is MIT, see `LICENSE`. The bundled STLs are CC0 1.0 by Creative
Tools, see `com.github.jakemathews.benchy/3DBenchy-LICENSE.md`.
