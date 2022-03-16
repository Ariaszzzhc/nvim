local status_ok, dap = pcall(require, "dap")

if not status_ok then
  return
end

local status_ok2, dap_virtual = pcall(require, "nvim-dap-virtual-text")

if not status_ok2 then
  return
end

local status_ok3, dap_installer = pcall(require, "dap-install")

if not status_ok3 then
  return
end

dap_virtual.setup {
  enabled = true,                     -- enable this plugin (the default)
  enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_new_as_changed = false,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  show_stop_reason = true,            -- show stop reason when stopped for exceptions
  commented = false,                  -- prefix virtual text with comment string
  -- experimental features:
  virt_text_pos = 'eol',              -- position of virtual text, see `:h nvim_buf_set_extmark()`
  all_frames = false,                 -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
  virt_lines = false,                 -- show virtual lines instead of virtual text (will flicker!)
  virt_text_win_col = nil             -- position the virtual text at a fixed window column (starting from the first text column) ,
                                      -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}

dap_installer.setup {
  installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
}

-- TODO: dap adapter & configuration
vim.fn.sign_define('DapBreakpoint', {text='●', texthl='DiagnosticSignError', linehl='', numhl=''})
dap_installer.config("codelldb", {})
