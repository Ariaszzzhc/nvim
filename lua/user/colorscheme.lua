vim.g.material_style = "darker"
local status_ok, material = pcall(require, "material")

if status_ok then
  material.setup({
    contrast = {
      sidebars = false,
      floating_windows = false,
      line_numbers = false,
      sign_column = false,
      cursor_line = false,
      non_current_windows = false,
      popup_menu = false,
    },

    italics = {
      comments = true,
      keywords = false,
      functions = false,
      strings = false,
      variables = false,
    },

    high_visibility = {
      lighter = true,
      darker = true,
    },
    sync_loading = true,
  })
end

vim.cmd "colorscheme material"

