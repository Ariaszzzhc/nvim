-- reload themes without restarting vim
-- if no theme name given then reload the current theme
local function reload_theme(theme)
  local reload_plugin = require("util.reload_plugin")

  if theme == nil or theme == "" then
    theme = vim.g["mirana_theme"]
  end

  if not pcall(require, "hl_themes." .. theme) then
    print("No such theme ( " .. theme .. " )")
    return false
  end

  vim.g["mirana_theme"] = theme

  require("user.colorscheme")

  if not reload_plugin {
    "user.bufferline",
    "user.statusline",
  } then
    print "Error: Not able to reload all plugins."
  end

  return true
end

return reload_theme
