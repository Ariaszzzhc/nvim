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

local M = {}

M.misc = function()
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

  basic_mapping()
  cmd "silent! command PackerClean lua require 'plugins' require('packer').clean()"
  cmd "silent! command PackerCompile lua require 'plugins' require('packer').compile()"
  cmd "silent! command PackerInstall lua require 'plugins' require('packer').install()"
  cmd "silent! command PackerStatus lua require 'plugins' require('packer').status()"
  cmd "silent! command PackerSync lua require 'plugins' require('packer').sync()"
  cmd "silent! command PackerUpdate lua require 'plugins' require('packer').update()"
end

return M
