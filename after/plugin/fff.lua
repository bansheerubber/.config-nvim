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

local vertical_layout = {
	prompt_position = 'top',
	preview_position = 'bottom',
	preview_size = '0.75',
	height = '0.9',
}

local horizontal_layout = {
	prompt_position = 'top',
	preview_position = 'right',
	preview_size = '0.6',
	height = '0.9',
}

local function aspect_ratio()
	local width = tonumber(vim.api.nvim_command_output("echo &columns")) or 0
	local height = (tonumber(vim.api.nvim_command_output("echo &lines")) or 0) * 2
	return width / height
end

vim.keymap.set(
	{ 'n', 'i', 'v' },
	'<C-p>',
	function()
		fff.find_files({
			layout = aspect_ratio() > 1 and horizontal_layout or vertical_layout,
		})
	end,
	{ desc = 'FFFind files' }
)

vim.keymap.set(
	{ 'n', 'i', 'v' },
	'<C-f>',
	function()
		fff.live_grep({
			layout = aspect_ratio() > 1 and horizontal_layout or vertical_layout,
		})
	end,
	{ desc = 'FFFind grep' }
)
