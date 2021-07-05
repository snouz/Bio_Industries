------------------------------------------------------------------------------------
--                                Game tweaks: Bots                               --
--                        (BI.Settings.BI_Game_Tweaks_Bot)                        --
------------------------------------------------------------------------------------
local setting = "BI_Game_Tweaks_Bot"
if not BI.Settings[setting] then
  BI.nothing_to_do("*")
  return
else
  BI.entered_file()
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------


-- Make bots immune to fire and unminable
local function immunify(bot)
  local can_insert = true
  bot.flags = bot.flags or {}
  bot.resistances = bot.resistances or {}

  for f, flag in pairs(bot.flags) do
    if flag == "not-flammable" then
      can_insert = false
      break
    end
  end
  if can_insert then
    table.insert(bot.flags, "not-flammable")
    --~ BioInd.writeDebug("Added flag \"not-flammable\" to %s", {bot.name})
    BioInd.modified_msg("flag \"not-flammable\"", bot, "Added")
  end

  can_insert = true
  for r, resistance in pairs(bot.resistances) do
    if resistance.type == "fire" and resistance.percent ~= 100 then
      --~ BioInd.writeDebug("Change resistance against \"fire\" from %s to 100 %% for %s",
                        --~ {resistance.percent or "nil", bot.name})
      bot.resistances[r] = {type = "fire", percent = 100}
      can_insert = false
      BioInd.modified_msg("fire resistance", bot)
      break
    end
  end
  if can_insert then
    table.insert(bot.resistances, {type = "fire", percent = 100})
    --~ BioInd.writeDebug("Added resistance against  \"fire\" to %s", {bot.name})
    BioInd.modified_msg("fire resistance", bot, "Added")
  end

  bot.minable = nil
  BioInd.writeDebug("Made  %s unminable", {bot.name})
  BioInd.modified_msg("minable", bot, "Removed")
end


-- Construction bots
for _, bot in pairs(data.raw['construction-robot'] or {}) do
  immunify(bot)
end

-- Logistic bots
for _, bot in pairs(data.raw['logistic-robot'] or {}) do
  immunify(bot)
end


------------------------------------------------------------------------------------
--                                    END OF FILE
------------------------------------------------------------------------------------
BI.entered_file("leave")
