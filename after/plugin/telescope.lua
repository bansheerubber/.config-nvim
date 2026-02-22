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

local function aspect_ratio()
	local width = tonumber(vim.api.nvim_command_output("echo &columns")) or 0
	local height = (tonumber(vim.api.nvim_command_output("echo &lines")) or 0) * 2
	return width / height
end

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

vim.keymap.set('n', '<leader>f', function()
	-- '<Cmd>Telescope file_browser sorting_strategy=ascending path=%:p:h select_buffer=true<CR>')
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
	builtin.treesitter({
		ignore_symbols = { 'var', 'namespace' },
		sorting_strategy = 'ascending',
		layout_strategy = aspect_ratio() > 1 and 'horizontal' or 'vertical',
		layout_config = aspect_ratio() > 1 and horizontal_layout or vertical_layout,
	})
end)

-- find string in all files
-- vim.keymap.set({ 'n', 'i', 'v' }, '<C-F>', function()
-- 	builtin.live_grep({
-- 		layout_strategy = 'vertical',
-- 		layout_config = {
-- 			height = 0.8,
-- 			mirror = true,
-- 			prompt_position = 'top',
-- 			preview_height = 0.75,
-- 		},
-- 	})
-- end)

vim.api.nvim_create_autocmd("User", {
	pattern = "TelescopePreviewerLoaded",
	callback = function()
		vim.wo.number = true
	end,
})
