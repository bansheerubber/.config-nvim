local fff = require('fff')

fff.setup({
	layout = {
		prompt_position = 'top',
		preview_position = 'bottom',
		preview_size = 0.75,
		flex = false,
	},
	preview = {
		line_numbers = true,
		highlight_line = 'screenline',
	},
})

local vertical_layout = {
	prompt_position = 'top',
	preview_position = 'bottom',
	preview_size = 0.75,
	height = 0.9,
	flex = false,
}

local horizontal_layout = {
	prompt_position = 'top',
	preview_position = 'right',
	preview_size = 0.6,
	height = 0.9,
	flex = false,
}

local function calc_preview_size()
	local preview_size = 0.75

	local height = math.floor(vim.o.lines * 0.9)
	local preview_height = math.floor(height * preview_size)
	local list_height = height - preview_height - 7

	-- make list have a minimum height of 20 lines
	if list_height < 20 then
		local derived_preview_height = height - 20 - 7
		return derived_preview_height / height
	end

	return preview_size
end

local function aspect_ratio()
	local width = vim.o.columns
	local height = vim.o.lines * 2
	return width / height
end

vim.keymap.set(
	{ 'n', 'i', 'v' },
	'<C-p>',
	function()
		vertical_layout.preview_size = calc_preview_size()

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
		vertical_layout.preview_size = calc_preview_size()

		fff.live_grep({
			layout = aspect_ratio() > 1 and horizontal_layout or vertical_layout,
		})
	end,
	{ desc = 'FFFind grep' }
)
