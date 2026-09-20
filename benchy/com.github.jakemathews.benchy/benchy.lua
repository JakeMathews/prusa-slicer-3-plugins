-- Copyright (c) 2026 Jake Mathews
-- SPDX-License-Identifier: MIT

-- Puts the official single-part #3DBenchy on the plate.
--
-- The STLs next to this file are unmodified copies from
-- https://github.com/CreativeTools/3DBenchy (CC0 1.0). The plugin sandbox has no
-- network or filesystem access, so the models ship inside the bundle rather than
-- being downloaded; see fetch-benchy.sh in the repository to refresh them from source.

info = {
    id = "benchy",
    type = "project.plugin",
    title = "Benchy",
    menu = "Benchy/Single-part",
    params = {}
}

function execute(_)
    api.project:add_object{
        mesh = api.load_stl("3DBenchy.stl"),
    }
end
