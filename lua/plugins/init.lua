local present, packer = pcall(require, "plugins.packerInit")

if not present then
  return false
end

local plugins = {
  { "wbthomason/packer.nvim", event = "VimEnter" }, -- Have packer manage itself
  { "nvim-lua/popup.nvim" }, -- An implementation of the Popup API from vim in Neovim
  { "nvim-lua/plenary.nvim" }, -- Useful lua functions used ny lots of plugins
  {
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.configs.others").autopairs()
    end,
  }, -- Autopairs, integrates with both cmp and treesitter
  {
    "numToStr/Comment.nvim",
    module = "Comment",
    keys = { "gcc" },
    config = function()
      require("plugins.configs.others").comment()
    end,
  }, -- Easily comment stuff
  { "kyazdani42/nvim-web-devicons", after = "nvim-base16.lua" },
  {
    "kyazdani42/nvim-tree.lua",
    after = "nvim-web-devicons",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require("plugins.configs.nvim-tree").setup()
    end,
  },
  {
    "akinsho/bufferline.nvim",
    after = "nvim-web-devicons",
    config = function()
      require("plugins.configs.bufferline").setup()
    end,
  },
  { "moll/vim-bbye" },
  {
    "feline-nvim/feline.nvim",
    after = "nvim-web-devicons",
    config = function()
      require("plugins.configs.statusline").setup()
    end,
  },
  { "akinsho/toggleterm.nvim" },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugins.configs.others").project()
    end,
  },
  { "lewis6991/impatient.nvim" },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.configs.others").blankline()
    end,
    event = "BufRead",
  },
  {
    "goolord/alpha-nvim",
    config = function()
      require("plugins.configs.alpha").setup()
    end,
  },
  { "antoinemadec/FixCursorHold.nvim" }, -- This is needed to fix lsp doc highlight

  {
    "NvChad/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("plugins.configs.others").colorizer()
    end,
  },

  -- cmp plugins
  {
    "hrsh7th/nvim-cmp",
    after = "friendly-snippets",
    config = function()
      require("plugins.configs.cmp").setup()
    end,
  }, -- The completion plugin
  { "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" }, -- buffer completions
  { "hrsh7th/cmp-path", after = "cmp-buffer" }, -- path completions
  {
    "hrsh7th/cmp-nvim-lua",
    after = "cmp_luasnip",
  },
  { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" }, -- snippet completions
  { "hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lua" },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    wants = "friendly-snippets",
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.others").luasnip()
    end,
  }, --snippet engine
  { "rafamadriz/friendly-snippets", module = "cmp_nvim_lsp", event = "InsertEnter" }, -- a bunch of snippets to use

  -- LSP
  { "neovim/nvim-lspconfig" }, -- enable LSP
  {
    "williamboman/nvim-lsp-installer",
    config = function()
      require("plugins.configs.lspconfig").setup_installer()
    end,
  }, -- simple to use language server installer
  { "tamago324/nlsp-settings.nvim" }, -- language server settings defined in json for
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("plugins.configs.null_ls").setup()
    end,
  }, -- for formatters and linters

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    -- cmd = "Telescope",
    config = function()
      require("plugins.configs.telescope").setup()
    end,
  },
  { "nvim-telescope/telescope-fzy-native.nvim" }, -- telescope native plugin
  {
    "folke/todo-comments.nvim",
    config = function()
      require("plugins.configs.others").todo()
    end,
  },
  { "nvim-telescope/telescope-ui-select.nvim" },

  {
    "NvChad/nvim-base16.lua",
    after = "packer.nvim",
    config = function()
      require("colors").init()
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    -- event = { "BufRead", "BufNewFile" },
    run = ":TSUpdate",
  },
  { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.configs.others").gitsigns()
    end,
  },

  -- Spell
  { "lewis6991/spellsitter.nvim" },

  {
    "Pocco81/TrueZen.nvim",
    cmd = {
      "TZAtaraxis",
      "TZMinimalist",
      "TZFocus",
    },
    config = function()
      require "plugins.configs.truezen"
    end,
  },

  -- -- Debug Adapter Protocol
  -- { "mfussenegger/nvim-dap" },
  -- { "nvim-telescope/telescope-dap.nvim" },
  -- { "theHamsta/nvim-dap-virtual-text" },
  -- { "rcarriga/nvim-dap-ui" },

  -- Editorconfig
  { "gpanders/editorconfig.nvim" },
}

return packer.startup(function(use)
  for _, v in pairs(plugins) do
    use(v)
  end
end)
