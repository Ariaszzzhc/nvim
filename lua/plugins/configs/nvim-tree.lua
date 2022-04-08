-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
local g = vim.g

g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
g.nvim_tree_git_hl = 0
g.nvim_tree_highlight_opened_files = 0
g.nvim_tree_indent_markers = 1
g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }

g.nvim_tree_show_icons = {
   folders = 1,
   files = 1,
   git = 1,
}

g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
     deleted = "",
     ignored = "◌",
     renamed = "➜",
     staged = "✓",
     unmerged = "",
     unstaged = "✗",
     untracked = "★",
  },
  folder = {
     default = "",
     empty = "",
     empty_open = "",
     open = "",
     symlink = "",
     symlink_open = "",
  },
}

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

-- local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
-- if not config_status_ok then
--   return
-- end

-- local tree_cb = nvim_tree_config.nvim_tree_callback

local opts = {
  filters = {
    dotfiles = false,
 },
 disable_netrw = true,
 hijack_netrw = true,
 ignore_ft_on_setup = { "dashboard" },
 auto_close = false,
 open_on_tab = false,
 hijack_cursor = true,
 hijack_unnamed_buffer_when_opening = false,
 update_cwd = true,
 update_focused_file = {
    enable = true,
    update_cwd = false,
 },
 view = {
    allow_resize = true,
    side = "left",
    width = 25,
    hide_root_folder = true,
 },
 git = {
    enable = false,
    ignore = false,
 },
 actions = {
    open_file = {
       resize_window = true,
    },
 },
}

local M = {}

M.setup = function()
  nvim_tree.setup(opts)
end

return M
