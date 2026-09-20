-- Copyright (c) 2026 Jake Mathews
-- SPDX-License-Identifier: MIT

-- Puts the official #3DBenchy on the plate.
--
-- The STL next to this file is the unmodified single-part 3DBenchy.stl from
-- https://github.com/CreativeTools/3DBenchy (CC0 1.0). The plugin sandbox has no
-- network or filesystem access, so the model ships inside the bundle rather than
-- being downloaded; see fetch-benchy.sh in the repository to refresh it from source.

info = {
    id = "benchy",
    type = "project.plugin",
    title = "Benchy",
    menu = "Benchy",
    params = {}
}

function execute(_)
    local mesh = api.load_stl("3DBenchy.stl")
    local aabb = mesh:bounds()

    api.project:add_object{
        mesh = mesh,
        -- The STL's origin is at the middle of the hull; drop it onto the bed.
        translate = {z = -aabb.min_z},
    }
end
