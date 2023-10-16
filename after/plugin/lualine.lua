local colors = {
	black        = '#282828',
	white        = '#ebdbb2',
	red          = '#fb4934',
	green        = '#b8bb26',
	blue         = '#83a598',
	yellow       = '#fe8019',
	gray         = '#a89984',
	darkgray     = '#3c3836',
	lightgray    = '#504945',
	inactivegray = '#7c6f64',

	background   = '#1B121F',
	foreground   = '#B7ACB7',
}

local theme = {
	normal = {
		a = { bg = colors.background, gui = 'bold' },
		b = { bg = colors.background, fg = colors.foreground },
		c = { bg = colors.background, fg = colors.foreground },
	},
	insert = {
		a = { bg = colors.background, gui = 'bold' },
		b = { bg = colors.background, fg = colors.foreground },
		c = { bg = colors.background, fg = colors.foreground },
	},
	visual = {
		a = { bg = colors.background, gui = 'bold' },
		b = { bg = colors.background, fg = colors.foreground },
		c = { bg = colors.background, fg = colors.foreground },
	},
	replace = {
		a = { bg = colors.background, gui = 'bold' },
		b = { bg = colors.background, fg = colors.foreground },
		c = { bg = colors.background, fg = colors.foreground },
	},
	command = {
		a = { bg = colors.background, gui = 'bold' },
		b = { bg = colors.background, fg = colors.foreground },
		c = { bg = colors.background, fg = colors.foreground },
	},
	inactive = {
		a = { bg = colors.background, gui = 'bold' },
		b = { bg = colors.background, fg = colors.foreground },
		c = { bg = colors.background, fg = colors.foreground },
	},
}

require('lualine').setup({
	options = {
		icons_enabled = false,
		component_separators = { left = '|', right = '|' },
		section_separators = { left = '', right = '' },
		theme = theme,
		refresh = {
			statusline = 100,
		},
	},
	sections = {
		lualine_a = { { 'mode', fmt = function(str) return str:lower() end } },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { 'filename' },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'searchcount', },
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {},
	},
})
