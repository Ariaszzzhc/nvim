-- bootstrap lazy.nvim, LazyVim and your plugins
if not vim.g.vscode then
  if vim.g.neovide then
    vim.o.guifont = "Symbols Nerd Font, Fira Code, monospace:h17"
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_cursor_antialiasing = true
  end

  require("config.lazy")
end
