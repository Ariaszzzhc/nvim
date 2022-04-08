local present, alpha = pcall(require, "alpha")
if not present then
	return
end

local function button(sc, txt, keybind)
  local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

  local opts = {
    position = "center",
    text = txt,
    shortcut = sc,
    cursor = 5,
    width = 36,
    align_shortcut = "right",
    hl = "AlphaButtons"
  }

  if keybind then
    opts.keymap = {
      "n",
      sc_,
      keybind,
      {
        noremap = true,
        silent = true,
      }
    }
  end

  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = opts,
  }
end

local ascii = {
  "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣼⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄",
  "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠙⣿⡟⠈⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄",
  "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣻⡆⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄",
  "⠄⠄⠄⠄⠄⠄⠄⣌⢉⣤⡄⠄⣿⡖⢠⣄⠉⠃⠄⠄⠄⠄⠄⠄⠄⠄⠄",
  "⠄⠄⠄⠄⠄⢰⠟⣿⠇⠄⠄⠄⣿⠉⣧⡄⠄⡽⡟⢷⣄⠄⠄⠄⠄⠄⠄",
  "⠄⠄⠄⠄⠹⣇⠄⠚⢧⡈⠛⠓⣻⠓⣛⡟⣥⡟⠁⢠⣿⠄⠄⠄⠄⠄⠄",
  "⠄⠄⠄⠄⠄⠄⠉⠿⢷⣶⣴⠟⣽⠿⠴⢤⣤⠾⢿⠄⠄⠄⠄⠄⠄⠄⠔",
  "⠄⠄⠈⠐⠶⣤⠄⠄⠄⠄⡄⠄⢸⡀⢠⡀⠄⠁⠄⣀⡴⠚⠋⠁⠄⠄⠄",
  "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠰⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄",
}

local header = {
  type = "text",
  val = ascii,
  opts = {
    position = "center",
    hl = "AlphaHeader"
  }
}

local buttons = {
   type = "group",
   val = {
     button("SPC f f", "  Find File  ", ":Telescope find_files<CR>"),
      button("SPC f n", "  New file", ":ene <BAR> startinsert <CR>"),
      button("SPC f o", "  Recent File  ", ":Telescope oldfiles<CR>"),
button("SPC p f", "  Find project", ":Telescope projects <CR>"),
      button("SPC f w", "  Find Word  ", ":Telescope live_grep<CR>"),
      button("SPC e s", "  Settings", ":e $MYVIMRC | :cd %:p:h <CR>"),
   },
   opts = {
      spacing = 1,
   },
}

local function footer()
-- NOTE: requires the fortune-mod package to work
	-- local handle = io.popen("fortune")
	-- local fortune = handle:read("*a")
	-- handle:close()
	-- return fortune
  -- local total_plugins = vim.cmd [[lua vim.tbl_keys(packer_plugins)]]
	return "Happy Coding"
end

local footers = {
  type="text",
  val = footer(),
  opts = {
    position = "center",
    hl = "Type",
  }
}


local M = {}

M.setup = function()
  alpha.setup {
    layout = {
      { type = "padding", val = 9 },
      header,
    { type = "padding", val = 2},
      buttons,
      footers,
    },
    opts = {}
  }
end

return M
