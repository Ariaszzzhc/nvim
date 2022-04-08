local util = require("lspconfig").util

return {
  filetypes = { "typescript" },
  root_dir = util.root_pattern("deno.json", "deno.jsonc", ".git"),
}
