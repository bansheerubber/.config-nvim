local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.set_preferences({
	sign_icons = {},
})

VirtualLines = true

vim.keymap.set(
	"",
	"<leader>l",
	function()
		if VirtualLines then
			vim.diagnostic.config({
				virtual_lines = {
					only_current_line = true,
				},
			})
		else
			vim.diagnostic.config({
				virtual_lines = false,
			})
		end

		VirtualLines = not VirtualLines
	end,
	{ desc = "Toggle lsp_lines" }
)

lsp.on_attach(function(_, bufnr)
	vim.diagnostic.config({
		virtual_lines = false,
		virtual_text = {
			prefix = '!',
			severity = vim.diagnostic.severity.ERROR,
		},
		update_in_insert = true,
	})

	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	-- vim.keymap.set("n", "<leader>vd", function() vim.lsp.buf.open_float() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>.", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>n", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

	vim.keymap.set("n", "<leader>j", function() vim.lsp.buf.format() end, opts)
end)

lsp.setup()

local cmp = require('cmp')
local luasnip = require('luasnip')

require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert {
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true
				})
			else
				fallback()
			end
		end, { 'i', 's' }),
	},
	sources = {
		{ name = 'luasnip' },
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
		{ name = 'buffer' },
		{ name = 'path' },
	},
})
