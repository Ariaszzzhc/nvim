local utils = require "core.utils"
local map_wrapper = utils.map

local cmd = vim.cmd

local map = function(...)
  local keys = select(2, ...)
  if not keys or keys == "" then
    return
  end
  map_wrapper(...)
end

local function basic_mapping()
  -- Don't copy the replaced text after pasting in visual mode
  map_wrapper("v", "p", "p:let @+=@0<CR>")

  -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
  -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
  -- empty mode is same as using :map
  -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
  map_wrapper({ "n", "x", "o" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
  map_wrapper({ "n", "x", "o" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
  map_wrapper("", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
  map_wrapper("", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

  -- use ESC to turn off search highlighting
  map_wrapper("n", "<Esc>", ":noh <CR>")

  -- center cursor when moving (goto_definition)

  -- yank from current cursor to end of line
  map_wrapper("n", "Y", "yg$")

  map("", "<Space>", "<Nop>")
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  -- Normal --
  -- Better window navigation
  map("n", "<C-h>", "<C-w>h")
  map("n", "<C-j>", "<C-w>j")
  map("n", "<C-k>", "<C-w>k")
  map("n", "<C-l>", "<C-w>l")

  -- Resize with arrows
  map("n", "<C-Up>", ":resize -2<CR>")
  map("n", "<C-Down>", ":resize +2<CR>")
  map("n", "<C-Left>", ":vertical resize -2<CR>")
  map("n", "<C-Right>", ":vertical resize +2<CR>")

  -- Move text up and down
  map("n", "<A-j>", "<Esc>:m .+1<CR>==gi")
  map("n", "<A-k>", "<Esc>:m .-2<CR>==gi")

  -- Visual --
  -- Stay in indent mode
  map("v", "<", "<gv")
  map("v", ">", ">gv")

  -- Move text up and down
  map("v", "<A-j>", ":m .+1<CR>==")
  map("v", "<A-k>", ":m .-2<CR>==")
  map("v", "p", '"_dP')

  -- Visual Block --
  -- Move text up and down
  map("x", "J", ":move '>+1<CR>gv-gv")
  map("x", "K", ":move '<-2<CR>gv-gv")
  map("x", "<A-j>", ":move '>+1<CR>gv-gv")
  map("x", "<A-k>", ":move '<-2<CR>gv-gv")
end

local function plugin_mapping()
  -- telescope
  map("n", "<leader>fb", ":Telescope buffers <CR>")
  map("n", "<leader>ff", ":Telescope find_files<CR>")
  map("n", "<leader>fa", ":Telescope find_files follow=true no_ignore=true hidden=true <CR>")
  map("n", "<leader>cm", ":Telescope git_commits <CR>")
  map("n", "<leader>gt", ":Telescope git_status <CR>")
  map("n", "<leader>fh", ":Telescope help_tags <CR>")
  map("n", "<leader>fw", ":Telescope live_grep <CR>")
  map("n", "<leader>fo", ":Telescope oldfiles <CR>")

  -- nvimtree
  map("n", "<C-n>", ":NvimTreeToggle <CR>")
  map("n", "<leader>e", ":NvimTreeFocus <CR>")

  -- lspconfig
  map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  map("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
  map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
  map("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
  map("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
  map("n", "<leader>ra", "<cmd>lua vim.lsp.buf.rename()<CR>")
  map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  map("n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>")
  map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
  map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
  map("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")
  map("n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>")

  -- comment
  map("n", "<leader>/", ":lua require('Comment.api').toggle_current_linewise()<CR>")
  map("v", "<leader>/", ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>")

  -- bufferline
  map("n", "<TAB>", ":BufferLineCycleNext <CR>")
  map("n", "<S-Tab>", ":BufferLineCyclePrev <CR>")
end

local M = {}

M.misc = function()
  basic_mapping()
  plugin_mapping()
  cmd "silent! command PackerClean lua require 'plugins' require('packer').clean()"
  cmd "silent! command PackerCompile lua require 'plugins' require('packer').compile()"
  cmd "silent! command PackerInstall lua require 'plugins' require('packer').install()"
  cmd "silent! command PackerStatus lua require 'plugins' require('packer').status()"
  cmd "silent! command PackerSync lua require 'plugins' require('packer').sync()"
  cmd "silent! command PackerUpdate lua require 'plugins' require('packer').update()"
end

return M
