local builtin = require('telescope.builtin')
local telescope = require('telescope')
telescope.load_extension('file_browser')

require('telescope').setup({
	extensions = {
		file_browser = {
			dir_icon = ' ',
			grouped = true,
			hidden = { file_browser = true, folder_browser = true },
		},
	},
})

-- vim.keymap.set(
-- 	{ 'n', 'i', 'v' },
-- 	'<C-p>',
-- 	function()
-- 		builtin.find_files({
-- 			no_ignore = true,
-- 			find_command = {
-- 				'rg',
-- 				'--files',
-- 				'--hidden',
-- 				'-g', '!.git',
-- 				'-g', '!node_modules',
-- 				'-g', '!target',
-- 				'-g', '!dist',
-- 			},
-- 		})
-- 	end
-- )

vim.keymap.set('n', '<leader>f', function()
	-- '<Cmd>Telescope file_browser sorting_strategy=ascending path=%:p:h select_buffer=true<CR>')
	require("telescope").extensions.file_browser.file_browser({
		sorting_strategy = 'ascending',
		path = '%:p:h',
		select_buffer = true,
		layout_strategy = 'vertical',
		layout_config = {
			height = 0.8,
			mirror = true,
			prompt_position = 'top',
			preview_height = 0.5,
		},
	})
end)

vim.keymap.set('n', '<leader>a', '<Cmd>Telescope session-lens search_session<CR>')

vim.keymap.set({ 'n', 'v', }, '<leader>t', function()
	builtin.treesitter({
		ignore_symbols = { 'var', 'namespace' },
		layout_strategy = 'vertical',
		layout_config = {
			height = 0.8,
			mirror = true,
			prompt_position = 'top',
			preview_height = 0.75,
		},
	})
end)

-- find string in all files
vim.keymap.set({ 'n', 'i', 'v' }, '<C-F>', function()
	builtin.live_grep({
		layout_strategy = 'vertical',
		layout_config = {
			height = 0.8,
			mirror = true,
			prompt_position = 'top',
			preview_height = 0.75,
		},
	})
end)

vim.api.nvim_create_autocmd("User", {
	pattern = "TelescopePreviewerLoaded",
	callback = function()
		vim.wo.number = true
	end,
})
