local util = require("lspconfig").util

return {
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_dir = util.root_pattern("package.json", "tsconfig.json", ".git"),
}
