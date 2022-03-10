-- set the global theme, used at various places like theme switcher, highlights
if not vim.g["mirana_theme"] then
  vim.g["mirana_theme"] = "onedark"
end

local status_ok, base16 = pcall(require, "base16")

local theme = vim.g["mirana_theme"]

if status_ok then
  -- first load the base16 theme
  base16(base16.themes(theme), true)

  -- unload to force reload
  package.loaded["colors.highlights" or false] = nil
  -- then load the highlights
  require "colors.highlights"
end
