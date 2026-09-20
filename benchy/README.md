# Benchy — a PrusaSlicer 3 plugin

A `project.plugin` for stock PrusaSlicer 3.x. It adds one _Plugins → Benchy_ menu item
that puts the official #3DBenchy on the plate, sitting on the bed, centred on the
selected bed.

## Why the STL is bundled

The plugin runtime is deliberately sandboxed: no `os`, no `io`, no network, and
`load_stl` may only read files that sit in the same directory as the plugin's `.lua`.
So the plugin cannot download anything. Instead the unmodified single-part
`3DBenchy.stl` from <https://github.com/CreativeTools/3DBenchy> lives inside the
bundle, next to `benchy.lua`.

#3DBenchy is released under CC0 1.0, and its licence page explicitly permits
redistribution "including it in software distributions". Details, source commit and
checksum are in [`com.github.jakemathews.benchy/3DBenchy-LICENSE.md`](com.github.jakemathews.benchy/3DBenchy-LICENSE.md).

To refresh the STL from the official archive:

```bash
./fetch-benchy.sh
```

## Installing

A plugin bundle is installed by putting its directory, **named exactly as the `id` in
`manifest.json`**, into the config directory's `lua/`, then running _Plugins → Rescan_.

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
_Help → Show Configuration Folder_ shows the right one; the `lua/` directory goes inside it.

## Using it

_Plugins → Benchy_. There are no parameters; the dialog just has the run button. One
Benchy appears on the currently selected bed, hull down. Run it again for another one
and let _Arrange_ spread them out.

## Licence

The plugin code is MIT, see `LICENSE`. The bundled `3DBenchy.stl` is CC0 1.0 by
Creative Tools, see `com.github.jakemathews.benchy/3DBenchy-LICENSE.md`.
