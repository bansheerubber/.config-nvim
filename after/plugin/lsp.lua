local lsp = require('lsp-zero')

lsp.set_sign_icons({
	error = "√",
	hint = "∘",
	info = "∘",
	warn = "∫",
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

require('luasnip.loaders.from_vscode').lazy_load()

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    lsp.default_setup,
    lua_ls = function()
      local lua_opts = lsp.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})

vim.keymap.set({ "n", "v", "i", }, "<M-l>", function() vim.cmd([[ LspRestart ]]) end, {})

lsp.on_attach(function(_, bufnr)
	vim.diagnostic.config({
		virtual_lines = false,
		virtual_text = {
			prefix = '√',
			severity = vim.diagnostic.severity.ERROR,
		},
		update_in_insert = true,
	})

	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition({ reuse_win = true }) end, opts)
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

local cmp = require('cmp')

cmp.setup.cmdline({
	mapping = {
		['<C-e>'] = {
			i = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true
			}),
			c = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true
			}),
		},
		['<CR>'] = {
			i = cmp.config.disable,
			c = cmp.config.disable,
		},
		['<Tab>'] = {
			i = cmp.mapping.disable,
			c = cmp.mapping.disable,
		},
	},
})

cmp.setup({
	mapping = {
		['<C-e>'] = {
			i = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true
			}),
			c = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true
			}),
		},
		['<C-Space>'] = {
			i = cmp.mapping.abort(),
			c = cmp.mapping.abort(),
		},
		['<CR>'] = {
			i = cmp.config.disable,
			c = cmp.config.disable,
		},
		['<Tab>'] = {
			i = cmp.mapping.disable,
			c = cmp.mapping.disable,
		},
	},
	preselect = cmp.PreselectMode.None,
	formatting = {
		fields = { 'menu', 'abbr', 'kind' },
		format = function(entry, item)
			local menu_icon = {
				copilot                 = '₹',
				nvim_lsp_signature_help = '∢',
				nvim_lsp                = '∿',
				nvim_lua                = '⅂',
				buffer                  = '∀',
				path                    = '∃',
			}

			local kinds = {
				Text          = ' text',
				Method        = 'methd',
				Function      = ' func',
				Constructor   = 'cnruc',
				Field         = 'field',
				Variable      = '  var',
				Class         = 'class',
				Interface     = 'intrf',
				Module        = '  mod',
				Property      = ' prop',
				Unit          = ' unit',
				Value         = '  val',
				Enum          = ' enum',
				Keyword       = 'kywrd',
				Snippet       = ' snip',
				Color         = 'color',
				File          = ' file',
				Reference     = '  ref',
				Folder        = 'foldr',
				EnumMember    = 'varnt',
				Constant      = 'const',
				Struct        = 'strct',
				Event         = 'evnet',
				Operator      = 'oprtr',
				TypeParameter = ' type',
			}

			item.kind = kinds[item.kind]
			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'nvim_lua' },
		{ name = 'copilot', },
		{ name = 'buffer' },
		{ name = 'path' },
	},
	window = {
		completion = {
			winhighlight = "Normal:CmpNormal,FloatBorder:CmpFloatBorder,CursorLine:CmpCursorLine,Search:CmpSearch",
		},
		documentation = {
			border = false,
			winhighlight = "Normal:CmpDocNormal,FloatBorder:CmpDocFloatBorder",
		},
	},
})
