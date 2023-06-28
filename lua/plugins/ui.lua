return {
  {
    "folke/noice.nvim",
    enabled = false,
  },

  {
    "catppuccin",
    opts = {
      transparent_background = true,
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-frappe",
    },
  },

  { import = "lazyvim.plugins.extras.ui.mini-starter" },
}
