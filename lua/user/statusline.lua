local status_ok, feline = pcall(require, "feline")
if not status_ok then
	return
end

local colors = require("colors").get()

local mode_colors = {
  ["n"] = { "NORMAL", colors.red },
  ["no"] = { "N-PENDING", colors.red },
  ["i"] = { "INSERT", colors.dark_purple },
  ["ic"] = { "INSERT", colors.dark_purple },
  ["t"] = { "TERMINAL", colors.green },
  ["v"] = { "VISUAL", colors.cyan },
  ["V"] = { "V-LINE", colors.cyan },
  [""] = { "V-BLOCK", colors.cyan },
  ["R"] = { "REPLACE", colors.orange },
  ["Rv"] = { "V-REPLACE", colors.orange },
  ["s"] = { "SELECT", colors.nord_blue },
  ["S"] = { "S-LINE", colors.nord_blue },
  [""] = { "S-BLOCK", colors.nord_blue },
  ["c"] = { "COMMAND", colors.pink },
  ["cv"] = { "COMMAND", colors.pink },
  ["ce"] = { "COMMAND", colors.pink },
  ["r"] = { "PROMPT", colors.teal },
  ["rm"] = { "MORE", colors.teal },
  ["r?"] = { "CONFIRM", colors.teal },
  ["!"] = { "SHELL", colors.green },
}

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local lsp = require "feline.providers.lsp"
local lsp_severity = vim.diagnostic.severity

local function add_table(a, b)
  table.insert(a, b)
end

local icon_styles = {
  left = "",
  right = "",
  main_icon = "  ",
  vi_mode_icon = " ",
  position_icon = " ",
}

local mode_icon = {
  provider = icon_styles.vi_mode_icon,
  hl = function()
    return {
       fg = colors.statusline_bg,
       bg = mode_colors[vim.fn.mode()][2],
    }
  end,
}

local diagnostics = {
  error = {
    provider = "diagnostic_errors",
    enabled = function()
      return lsp.diagnostics_exist(lsp_severity.ERROR)
    end,
    hl = { fg = colors.red },
    icon = "  ",
  },

  warning = {
    provider = "diagnostic_warnings",
    enabled = function()
      return lsp.diagnostics_exist(lsp_severity.WARN)
    end,
    hl = { fg = colors.yellow },
    icon = "  ",
  },

  hint = {
    provider = "diagnostic_hints",
    enabled = function()
         return lsp.diagnostics_exist(lsp_severity.HINT)
    end,
    hl = { fg = colors.grey_fg2 },
    icon = "  ",
  },

  info = {
    provider = "diagnostic_info",
    enabled = function()
      return lsp.diagnostics_exist(lsp_severity.INFO)
    end,
    hl = { fg = colors.green },
    icon = "  ",
  },
}

local diff = {
  add = {
    provider = "git_diff_added",
    icon = "  ",
    enabled = hide_in_width,
    hl = {
      fg = colors.grey_fg2,
      bg = colors.statusline_bg
    },
  },

  change = {
    provider = "git_diff_changed",
    icon = "  ",
    enabled = hide_in_width,
    hl = {
      fg = colors.grey_fg2,
      bg = colors.statusline_bg
    },
  },

  remove = {
    provider = "git_diff_removed",
    icon = "  ",
    enabled = hide_in_width,
    hl = {
      fg = colors.grey_fg2,
      bg = colors.statusline_bg
    },
  },
}

local treesitter = {
  provider = function ()
    local buf = vim.api.nvim_get_current_buf()
    if next(vim.treesitter.highlighter.active[buf]) then
      return "   "
    end

    return ""
  end,

  enabled = hide_in_width,

  hl = {
    fg = colors.green,
    bg = colors.statusline_bg,
  },
}

local filetype = {
  provider = {
    name = "file_type",
    opts = {
      filetype_icon = false,
      colored_icon = false,
      case = "titlecase"
    }
  },

  right_sep = {
    str = icon_styles.right,
    hl = {
      fg = colors.nord_blue,
      bg = colors.lightbg,
   },
  },

  hl = {
    fg = colors.statusline_bg,
    bg = colors.nord_blue,
  },
}

local lsp_progress = {
  provider = function()
    local lsp_client = vim.lsp.util.get_progress_messages()[1]

    if lsp_client then
      local msg = lsp_client.message or ""
      local percentage = lsp_client.percentage or 0
      local title = lsp_client.title or ""
      local spinners = {
        "",
        "",
        "",
      }

      local success_icon = {
        "",
        "",
        "",
      }

      local ms = vim.loop.hrtime() / 1000000
      local frame = math.floor(ms / 120) % #spinners

      if percentage >= 70 then
        return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
      end

      return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
    end

    return ""
  end,

  hl = {
    fg = colors.green,
    bg = colors.statusline_bg,
  },
  enabled = hide_in_width
}

local lsp_icon = {
  provider = function()
    if next(vim.lsp.buf_get_clients()) ~= nil then
      return "  LSP"
    else
      return ""
    end
  end,
  hl = {
    fg = colors.grey_fg2,
    bg = colors.statusline_bg,
  },
  enabled = hide_in_width
}

local branch = {
	provider = "git_branch",
	icon = "  ",
  right_sep = {
    str = icon_styles.right,
    hl = {
      fg = colors.lightbg,
      bg = colors.lightbg2
    },
  },
  hl = {
    fg = colors.white,
    bg = colors.lightbg,
 },
}

local location = {
  provider = {
    name = "position",
    opts = {
      padding = false,
    }
  },
  hl = {
    fg = colors.green,
    bg = colors.one_bg,
 },
}

local spaces = {
  provider = function()
    return " spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
  end,

  hl = {
    fg = colors.grey_fg2,
    bg = colors.statusline_bg,
 },
}

local encoding = {
  provider = "file_encoding",
  hl = {
    fg = colors.grey_fg2,
    bg = colors.statusline_bg,
 },
}

local main = {
  provider = icon_styles.main_icon,

  hl = {
    fg = colors.statusline_bg,
    bg = colors.nord_blue,
  },
}

local position_icon = {
  provider = icon_styles.position_icon,
  enabled = hide_in_width,
  hl = {
    fg = colors.black,
    bg = colors.green,
 },
}

local separator_right = {
  provider = icon_styles.left,
  enabled = hide_in_width,
  hl = {
    fg = colors.grey,
    bg = colors.one_bg,
 },
}

local separator_right2 = {
  provider = icon_styles.left,
  enabled = hide_in_width,
  hl = {
    fg = colors.green,
    bg = colors.grey,
 },
}

local empty_spaces = {
  provider = " " .. icon_styles.left,

  hl = {
    fg = colors.one_bg2,
    bg = colors.statusline_bg,
 },
}

local empty_spaces_colored = {
  provider = icon_styles.left,
  hl = function()
    return {
       fg = mode_colors[vim.fn.mode()][2],
       bg = colors.one_bg2,
    }
 end,
}

local empty_spaces2 = {
  provider = function()
    return " " .. mode_colors[vim.fn.mode()][1] .. " "
  end,

  hl = function()
    return {
       fg = mode_colors[vim.fn.mode()][2],
       bg = colors.one_bg,
    }
  end
}

local cpns = {
  active = {},
  inactive = {},
}

local left = {}
local middle = {}
local right = {}

add_table(left, main)
add_table(left, filetype)
add_table(left, branch)
add_table(left, diff.add)
add_table(left, diff.change)
add_table(left, diff.remove)
add_table(left, diagnostics.error)
add_table(left, diagnostics.warning)
add_table(left, diagnostics.hint)
add_table(left, diagnostics.info)

add_table(middle, lsp_progress)

add_table(right, treesitter)
add_table(right, lsp_icon)
add_table(right, spaces)
add_table(right, encoding)
add_table(right, empty_spaces)
add_table(right, empty_spaces_colored)
add_table(right, mode_icon)
add_table(right, empty_spaces2)
add_table(right, separator_right)
add_table(right, separator_right2)
add_table(right, position_icon)
add_table(right, location)

cpns.active[1] = left
cpns.active[2] = middle
cpns.active[3] = right

local inactive_left = {}
local inactive_right = {}

add_table(inactive_left, {})
add_table(inactive_left, {})
add_table(inactive_left, {
  provider = {
    name = "file_info",
    opts = {
      type = "unique",
    }
  }
})

add_table(inactive_right, {
  provider = {
    name = "position",
    opts = {
      padding = true,
    }
  }
})

cpns.inactive[1] = inactive_left
cpns.inactive[2] = inactive_right

feline.setup({
  components = cpns,
  disable = {
    filetypes = {
      "NvimTree",
      "dashboard",
      "alpha",
      "Outline",
    },
    buftypes = {
      "terminal",
    },
  },
})
