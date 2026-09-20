-- Copyright (c) 2026 Jake Mathews
-- SPDX-License-Identifier: MIT

-- The official dual-print #3DBenchy: one object, two parts, for a two-colour print.
--
--   hull  Hull, cargo box, bridge walls, rod holder, chimney
--   deck  Gunwale, deck, name plate, wheel, door/window frames, roof, chimney top
--
-- Each part is assigned an extruder here so the object slices two-colour straight
-- away on a multi-material printer. On a single-extruder printer the numbers are
-- harmless; the slicer prints everything with the one extruder it has.

info = {
    id = "benchy_dual",
    type = "project.plugin",
    title = "Benchy (dual-print)",
    menu = "Benchy/Dual-print (2 parts)",
    params = {
        {name = "hull_extruder", label = "Hull extruder", type = "int", default = 1},
        {name = "deck_extruder", label = "Deck extruder", type = "int", default = 2},
    }
}

function execute(opts)
    api.project:add_object{
        mesh = api.load_stl("dual-hull.stl"),
        type = VolumeType.Solid,
        params = {extruder = opts.hull_extruder},
        other_volumes = {
            {
                mesh = api.load_stl("dual-deck.stl"),
                type = VolumeType.Solid,
                params = {extruder = opts.deck_extruder},
            },
        },
    }
end
