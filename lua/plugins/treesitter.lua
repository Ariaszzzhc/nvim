local plugin = {
  "nvim-treesitter/nvim-treesitter",
  -- lazy = true,
  build = ":TSUpdate",
  config = function ()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "html",
        "javascript",
        "typescript",
        "json",
        "markdown",
        "python",
        "lua",
        "rust"
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 2000,
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      matchup = {
        enable = true,
      },
    }
  end
}

return plugin
