local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local builtin = null_ls.builtins

local M = {}

local sources = {

  builtin.formatting.stylua,
  builtin.diagnostics.luacheck.with {
    extra_args = { "--global vim" },
  },

  -- webdev
  builtin.formatting.deno_fmt.with {
    filetypes = { "typescript" },
  },
  builtin.formatting.prettier.with {
    filetypes = {
      "html",
      "markdown",
      "css",
      "typescriptreact",
      "javascript",
      "javascriptreact",
      "vue",
      "scss",
      "less",
      "yaml",
      "json",
    },
  },

  -- kotlin
  builtin.formatting.ktlint,
  builtin.diagnostics.ktlint,

  -- python
  builtin.formatting.black,
  builtin.diagnostics.flake8,

  -- rust
  builtin.formatting.rustfmt,
}

M.setup = function()
  null_ls.setup {
    debug = true,
    sources = sources,

    on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
        vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
      end
    end,
  }
end

return M
