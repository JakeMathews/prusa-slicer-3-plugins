# PrusaSlicer 3 plugins

Lua plugins for stock PrusaSlicer 3.x, the user-invoked kind that live under the
_Plugins_ menu.

| directory | what it does |
|---|---|
| [`benchy/`](benchy/) | Puts the official #3DBenchy on the plate. |

## Installing one

Symlink (or copy) the bundle directory, named exactly as its `manifest.json` `id`, into
`<config dir>/lua/` and run _Plugins → Rescan_. Each plugin's README has the exact
command for macOS and Linux.
