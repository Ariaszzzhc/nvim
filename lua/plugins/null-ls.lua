local plugin = {
  "jose-elias-alvarez/null-ls.nvim",
  config = function ()
    local null_ls = require("null-ls")

    local builtin = null_ls.builtin

    local sources = {
      builtin.formatting.stylua,
      builtin.diagnostics.luacheck.with {
        extra_args = {
          "--global vim",
        },
      },

      builtin.formatting.ktlint,
      builtin.diagnostics.ktlint,

      builtin.formatting.black,
      builtin.diagnostics.flake8,

      builtin.formatting.rustfmt,
    }

    null_ls.setup {
      debug = true,
      sources = sources,

      on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
          vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
        end
      end
    }
  end
}

return plugin
