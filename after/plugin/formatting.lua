local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    go = { "goimports", "gofmt" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
  },
  lsp_fallback = true,
})

-- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
-- vim.o.format = "v:lua.require'conform'.format()"
vim.lsp.buf.format = conform.format
