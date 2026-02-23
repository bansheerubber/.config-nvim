local builtin = require('telescope.builtin')
local telescope = require('telescope')
telescope.load_extension('file_browser')

telescope.setup({
	extensions = {
		file_browser = {
			dir_icon = ' ',
			grouped = true,
			hidden = { file_browser = true, folder_browser = true },
		},
	},
})

local vertical_layout = {
	height = 0.9,
	mirror = true,
	prompt_position = 'top',
	preview_height = 0.75,
}

local horizontal_layout = {
	height = 0.9,
	prompt_position = 'top',
	preview_width = 0.6,
}

local function calc_preview_size()
	local preview_size = 0.75

	local height = math.floor(vim.o.lines * 0.9)
	local preview_height = math.floor(height * preview_size)
	local list_height = height - preview_height - 8

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

vim.keymap.set('n', '<leader>f', function()
	vertical_layout.preview_height = calc_preview_size()

	telescope.extensions.file_browser.file_browser({
		sorting_strategy = 'ascending',
		path = '%:p:h',
		select_buffer = true,
		layout_strategy = aspect_ratio() > 1 and 'horizontal' or 'vertical',
		layout_config = aspect_ratio() > 1 and horizontal_layout or vertical_layout,
	})
end)

vim.keymap.set('n', '<leader>a', '<Cmd>Telescope session-lens search_session<CR>')

vim.keymap.set({ 'n', 'v', }, '<leader>t', function()
	vertical_layout.preview_height = calc_preview_size()

	builtin.treesitter({
		ignore_symbols = { 'var', 'namespace' },
		sorting_strategy = 'ascending',
		layout_strategy = aspect_ratio() > 1 and 'horizontal' or 'vertical',
		layout_config = aspect_ratio() > 1 and horizontal_layout or vertical_layout,
	})
end)

vim.api.nvim_create_autocmd("User", {
	pattern = "TelescopePreviewerLoaded",
	callback = function()
		vim.wo.number = true
	end,
})
