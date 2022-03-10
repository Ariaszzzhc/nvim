local function reload_plugin(plugins)
  local status = true
  local _reload_plugin = function(plugin)
    local loaded = package.loaded[plugin]
    if loaded then
      package.loaded[plugin] = nil
    end

    local ok, err = pcall(require, plugin)
    if not ok then
      print("Error: Cannot load " .. plugin .. " plugin!\n" .. err .. "\n")
      status = false
    end
  end

  if type(plugins) == "string" then
    _reload_plugin(plugins)
  elseif type(plugins) == "table" then
    for _, plugin in ipairs(plugins) do
      _reload_plugin(plugin)
    end
  end

  return status
end

return reload_plugin
