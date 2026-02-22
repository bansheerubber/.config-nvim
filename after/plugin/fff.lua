local fff = require('fff')

fff.setup({
	layout = {
		prompt_position = 'top',
		preview_position = 'bottom',
		preview_size = '0.75',
	},
	preview = {
		line_numbers = true,
	},
})

vim.keymap.set(
	{ 'n', 'i', 'v' },
	'<C-p>',
	function() require('fff').find_files() end,
	{ desc = 'FFFind files' }
)
