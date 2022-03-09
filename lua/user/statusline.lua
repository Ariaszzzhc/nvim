local status_ok, feline = pcall(require, "feline")
if not status_ok then
	return
end

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
  right = " ",
  main_icon = "  ",
  vi_mode_icon = " ",
  position_icon = " ",
}

local diagnostics = {
  error = {
    provider = "diagnostic_errors",
    enabled = function()
      return lsp.diagnostics_exist(lsp_severity.ERROR)
    end,
    icon = "  ",
  },

  warning = {
    provider = "diagnostic_warnings",
    enabled = function()
      return lsp.diagnostics_exist(lsp_severity.WARN)
    end,
    icon = "  ",
  },

  hint = {
    provider = "diagnostic_hints",
    enabled = function()
         return lsp.diagnostics_exist(lsp_severity.HINT)
    end,
    icon = "  ",
  },

  info = {
    provider = "diagnostic_info",
    enabled = function()
      return lsp.diagnostics_exist(lsp_severity.INFO)
    end,
    icon = "  ",
  },
}

local diff = {
  add = {
    provider = "git_diff_added",
    icon = " ",
    enabled = hide_in_width,
  },

  change = {
    provider = "git_diff_changed",
    icon = "  ",
    enabled = hide_in_width,
  },

  remove = {
    provider = "git_diff_removed",
    icon = "  ",
    enabled = hide_in_width,
  },
}

local filetype = {
  provider = {
    name = "file_type",
    opts = {
      filetype_icon = true,
      colored_icon = true,
      case = "titlecase"
    }
  }
}

local branch = {
	provider = "git_branch",
	icon = "  ",

  right_sep = {
    str = icon_styles.right,
  }
}

local location = {
  provider = {
    name = "position",
    opts = {
      padding = false,
    }
  }
}

-- cool function for progress
local progress = {
  provider = function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	  local line_ratio = current_line / total_lines
	  local index = math.ceil(line_ratio * #chars)
	  return chars[index]
  end
}

local spaces = {
  provider = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  end
}

local encoding = {
  provider = "file_encoding"
}

local mode = {
  provider = icon_styles.vi_mode_icon
}

local main = {
  provider = icon_styles.main_icon,
  right_sep = {
    str = icon_styles.right,
  }
}

local cpns = {
  active = {},
  inactive = {},
}

local left = {}
local middle = {}
local right = {}

add_table(left, main)
add_table(left, branch)
add_table(left, diagnostics.error)
add_table(left, diagnostics.warning)
add_table(left, diagnostics.hint)
add_table(left, diagnostics.info)
add_table(left, mode)

add_table(right, diff.add)
add_table(right, diff.change)
add_table(right, diff.remove)
add_table(right, spaces)
add_table(right, encoding)
add_table(right, filetype)
add_table(right, location)
add_table(right, progress)

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
