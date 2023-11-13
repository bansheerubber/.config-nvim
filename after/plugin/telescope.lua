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

vim.keymap.set(
	{ 'n', 'i', 'v' },
	'<C-p>',
	function()
		builtin.find_files({
			no_ignore = true,
			find_command = {
				'rg',
				'--files',
				'--hidden',
				'-g', '!.git',
				'-g', '!node_modules',
				'-g', '!target',
				'-g', '!dist',
			},
		})
	end
)

vim.keymap.set('n', '<leader>f',
	'<Cmd>Telescope file_browser sorting_strategy=ascending path=%:p:h select_buffer=true<CR>')

vim.keymap.set('n', '<leader>a', '<Cmd>Telescope session-lens search_session<CR>')

vim.keymap.set({ 'n', 'v', }, '<leader>t', function() builtin.treesitter({ ignore_symbols = { 'var', 'namespace' } }) end)

-- find string in all files
vim.keymap.set({ 'n', 'i', 'v' }, '<C-F>', function()
	builtin.live_grep()
end)
