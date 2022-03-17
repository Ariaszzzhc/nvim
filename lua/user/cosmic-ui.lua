local status_ok, ui = pcall(require, "cosmic-ui")

if not status_ok then
  return
end

ui.setup {
  -- default border to use
  -- 'single', 'double', 'rounded', 'solid', 'shadow'
  border_style = 'rounded',

  -- rename popup settings
  rename = {
    border = {
      highlight = 'Normal',
      style = 'rounded',
      title = ' Rename ',
      title_align = 'left',
      title_hl = 'Normal',
    },
    prompt = '> ',
    prompt_hl = 'Comment',
  },

  code_actions = {
    min_width = nil,
    border = {
      bottom_hl = 'Normal',
      highlight = 'Normal',
      style = 'rounded',
      title = 'Code Actions',
      title_align = 'center',
      title_hl = 'Normal',
    },
  }
}

vim.api.nvim_set_keymap("n", "gn", "<cmd>lua require('cosmic-ui').rename()<cr>", { noremap = true, silent = true })
