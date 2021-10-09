BioInd.debugging.entered_file()

local plugins = {
  'on_entity_created',
}
for p, plugin in pairs(plugins) do
  erlib_enable_plugin(plugin)
end

--~ if settings.startup["bzsilicon-more-intermediates"] then
  --~ settings.startup["bzsilicon-more-intermediates"].hidden = true
  --~ settings.startup["bzsilicon-more-intermediates"].default_value = "yes"
  --~ BioInd.debugging.show("Changed setting from bzsilicon", settings.startup["bzsilicon-more-intermediates"])
--~ end
BioInd.debugging.entered_file("leave")
