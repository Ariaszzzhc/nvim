local M = {}
require("plugins.configs.others").lsp_handlers()

function M.on_attach(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

-- setup lsp
M.setup_installer = function()
  local present, installer = pcall(require, "nvim-lsp-installer")
  if not present then
    return
  end
  installer.on_server_ready(function(server)
    local opts = {
      on_attach = M.on_attach,
      capabilities = capabilities,
    }

    if server.name == "jsonls" then
      local jsonls_opts = require "plugins.configs.lsp.jsonls"
      opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    end

    if server.name == "sumneko_lua" then
      local sumneko_opts = require "plugins.configs.lsp.sumneko_lua"
      opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server.name == "denols" then
      local denols_opts = require "plugins.configs.lsp.denols"
      opts = vim.tbl_deep_extend("force", denols_opts, opts)
    end

    if server.name == "tsserver" then
      local tsserver_opts = require "plugins.configs.lsp.tsserver"
      opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
    end

    server:setup(opts)
  end)
end

return M
