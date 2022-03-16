-- set the global theme, used at various places like theme switcher, highlights
local colorscheme = function(theme)
  if not theme then
    theme = "gruvchad"
  end

  vim.g["mirana_theme"] = theme

  local status_ok, base16 = pcall(require, "base16")

  if status_ok then
    -- first load the base16 theme
    base16(base16.themes(theme), true)

    -- unload to force reload
    package.loaded["colors.highlights" or false] = nil
    -- then load the highlights
    require "colors.highlights"
  end
end

colorscheme()

return colorscheme
