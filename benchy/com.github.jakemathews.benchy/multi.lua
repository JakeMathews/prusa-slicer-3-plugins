-- Copyright (c) 2026 Jake Mathews
-- SPDX-License-Identifier: MIT

-- The official multi-part #3DBenchy: one object made of its 17 named parts, so each
-- can be given its own extruder, colour or settings in the object list.
--
-- The parts arrive on the same extruder. Assign extruders per part in the object
-- list afterwards, or use the dual-print variant for a ready-made two-colour split.

info = {
    id = "benchy_multi",
    type = "project.plugin",
    title = "Benchy (multi-part)",
    menu = "Benchy/Multi-part (17 parts)",
    params = {}
}

-- Hull first: it is the object's main part; the rest are added as further solid parts.
local parts = {
    "bridge-roof",
    "bridge-walls",
    "cargo-box",
    "chimney-body",
    "chimney-top",
    "deck-surface",
    "doorframe-port",
    "doorframe-starboard",
    "fishing-rod-holder",
    "gunwale",
    "hawsepipe-port",
    "hawsepipe-starboard",
    "stern-name-plate",
    "stern-window",
    "wheel",
    "window",
}

function execute(_)
    local other_volumes = {}
    for _, name in ipairs(parts) do
        table.insert(other_volumes, {
            mesh = api.load_stl("part-" .. name .. ".stl"),
            type = VolumeType.Solid,
        })
    end

    api.project:add_object{
        mesh = api.load_stl("part-hull.stl"),
        other_volumes = other_volumes,
    }
end
