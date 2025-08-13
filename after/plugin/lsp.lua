local lsp = require('lsp-zero')
local cmp = require('cmp')
local lsp_signature = require('lsp_signature')
local util = require 'lspconfig.util'

require('lspconfig').gdscript.setup({
	port = 6008
})

lsp_signature.setup({
	doc_lines = 0, -- TODO add keybind that toggles docs
	handler_opts = {
		border = "single",
	},
	hint_enable = false,
})

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

function setcmp()
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
		mapping = cmp.mapping.preset.insert({
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
		}),
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
			{ name = 'nvim_lua' },
			-- { name = 'copilot', },
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
end

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

vim.api.nvim_create_augroup('setcmp', { clear = true })
vim.api.nvim_create_autocmd({ 'VimEnter', 'BufRead', }, {
	group = 'setcmp',
	callback = function()
		setcmp()
	end,
})

---@param bufnr integer
---@param mode "v"|"V"
---@return table {start={row,col}, end={row,col}} using (1, 0) indexing
local function range_from_selection(bufnr, mode)
  -- TODO: Use `vim.fn.getregionpos()` instead.

  -- [bufnum, lnum, col, off]; both row and column 1-indexed
  local start = vim.fn.getpos('v')
  local end_ = vim.fn.getpos('.')
  local start_row = start[2]
  local start_col = start[3]
  local end_row = end_[2]
  local end_col = end_[3]

  -- A user can start visual selection at the end and move backwards
  -- Normalize the range to start < end
  if start_row == end_row and end_col < start_col then
    end_col, start_col = start_col, end_col --- @type integer, integer
  elseif end_row < start_row then
    start_row, end_row = end_row, start_row --- @type integer, integer
    start_col, end_col = end_col, start_col --- @type integer, integer
  end
  if mode == 'V' then
    start_col = 1
    local lines = vim.api.nvim_buf_get_lines(bufnr, end_row - 1, end_row, true)
    end_col = #lines[1]
  end
  return {
    ['start'] = { start_row, start_col - 1 },
    ['end'] = { end_row, end_col - 1 },
  }
end

local function ts_format(ts_client, bufnr)
	---@type lsp.CodeActionParams
	local params

	local mode = vim.api.nvim_get_mode().mode
	local win = vim.api.nvim_get_current_win()
	if mode == 'v' or mode == 'V' then
		local range = range_from_selection(bufnr, mode)
		params =
			vim.lsp.util.make_given_range_params(range.start, range['end'], bufnr, ts_client.offset_encoding)
	else
		params = vim.lsp.util.make_range_params(win, ts_client.offset_encoding)
	end

	--- @cast params lsp.CodeActionParams

	local context = {
		only = { "source.organizeImports" },
		diagnostics = {},
		triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
	}

	local ns_push = vim.lsp.diagnostic.get_namespace(ts_client.id, false)
	local ns_pull = vim.lsp.diagnostic.get_namespace(ts_client.id, true)
	local diagnostics = {}
	local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
	vim.list_extend(diagnostics, vim.diagnostic.get(bufnr, { namespace = ns_pull, lnum = lnum }))
	vim.list_extend(diagnostics, vim.diagnostic.get(bufnr, { namespace = ns_push, lnum = lnum }))

	params.context = vim.tbl_extend('force', context, {
		---@diagnostic disable-next-line: no-unknown
		diagnostics = vim.tbl_map(function(d)
			return d.user_data.lsp
		end, diagnostics),
	})

	ts_client:request(
		'textDocument/codeAction',
		params,
		---@param result (lsp.Command|lsp.CodeAction)[]|nil
		function(err, result, ctx)
			if err ~= nil then
				print(err.message)
			end

			local function apply_action(action)
				if action.edit then
					vim.lsp.util.apply_workspace_edit(action.edit, ts_client.offset_encoding)
				end
				local a_cmd = action.command
				if a_cmd then
					local command = type(a_cmd) == 'table' and a_cmd or action
					--- @cast command lsp.Command
					ts_client:exec_cmd(command, ctx)
				end
			end

			for _, action in pairs(result or {}) do
				apply_action(action)
			end

			vim.lsp.buf.format()
			vim.cmd("write")
		end,
		bufnr
	)
end

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

	vim.keymap.set("n", "<leader>j", function()
		local ts_client = util.get_active_client_by_name(bufnr, 'ts_ls')
		if ts_client then
			ts_format(ts_client, bufnr)
		else
			vim.lsp.buf.format()
			vim.cmd("write")
		end
	end, opts)

	setcmp()
end)

setcmp()
