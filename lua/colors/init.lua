local M = {}

-- returns a table of colors for given or current theme
M.get = function(theme)
  if not theme then
    theme = vim.g["mirana_theme"]
  end

  return require("hl_themes." .. theme)
end

return M
