------------------------------------------------------------------------------------
--                             Enable: Rubber products                            --
--                             (BI.Settings.BI_Rubber)                            --
------------------------------------------------------------------------------------
local setting = "BI_Rubber"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end

BI.additional_entities = BI.additional_entities or {}
BI.additional_entities[setting] = BI.additional_entities[setting] or {}


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


--~ local ICONPATH = BioInd.iconpath
--~ local ENTITYPATH = BioInd.entitypath

--~ local SNDPATH = "__base__/sound/"

--~ local sound_def = require("__base__.prototypes.entity.sounds")
--~ local sounds = {}

--~ sounds.car_wood_impact = sound_def.car_wood_impact(0.8)
--~ sounds.generic_impact = sound_def.generic_impact

--~ for _, sound in ipairs(sounds.generic_impact) do
  --~ sound.volume = 0.65
--~ end

--~ sounds.open_sound = { filename = SNDPATH .. "wooden-chest-open.ogg" }
--~ sounds.close_sound = { filename = SNDPATH .. "wooden-chest-close.ogg" }

--~ sounds.walking_sound = {}
--~ for i = 1, 11 do
  --~ sounds.walking_sound[i] = {
    --~ filename = SNDPATH .. "walking/concrete-" .. (i < 10 and "0" or "")  .. i ..".ogg",
    --~ volume = 1.2
  --~ }
--~ end


--~ ------------------------------------------------------------------------------------
--~ --                                   Entity data                                  --
--~ ------------------------------------------------------------------------------------
--~ -- Basic seed bomb
--~ BI.additional_entities[setting].seed_bomb_projectile_1 = {

------------------------------------------------------------------------------------
--                          Create entities and remnants                          --
------------------------------------------------------------------------------------
for e, e_data in pairs(BI.additional_entities[setting] or {}) do
  -- Entity
  BioInd.create_stuff(e_data)

  -- Remnants, if they exist
  BioInd.make_remnants_for_entity(BI.additional_remnants[setting], e_data)
end

------------------------------------------------------------------------------------
--                                    END OF FILE                                 --
------------------------------------------------------------------------------------
BI.entered_file("leave")
