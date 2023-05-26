local Loader = {}

function Loader:get_plugins()
  local plugin_path = vim.fn.stdpath("config") .. "/lua/plugins"
  local list = {}
  local plugin_list = vim.split(vim.fn.glob(plugin_path .. "/*.lua"), "\n")
  if type(plugin_list) == "table" then
    for _, file in ipairs(plugin_list) do
      list[#list + 1] = file:sub(#plugin_path - 6, -1)
    end
  end

  return list
end

function Loader:load_plugins()
  self.plugins = {}

  -- Get plugins files
  local plugins = self:get_plugins()

  for _, p in ipairs(plugins) do
    local plugin = require(p:sub(0, #p - 4))

    if type(plugin) == "table" then
        self.plugins[#self.plugins + 1] = plugin
    end
  end
end

function Loader:init()
  local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazy_path,
    })
  end

  self:load_plugins()

  vim.opt.rtp:prepend(lazy_path)

  local settings = {}

  require("lazy").setup(self.plugins, settings)
end

Loader:init()

