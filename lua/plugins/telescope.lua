local vertical_layout = {
	height = 0.9,
	mirror = true,
	prompt_position = "top",
	preview_height = 0.75,
}

local horizontal_layout = {
	height = 0.9,
	prompt_position = "top",
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

local function path_display(opts, path)
	local tail = require("telescope.utils").path_tail(path)
	local directory = path:gsub("/" .. tail, "")
	path = string.format("%s %s", tail, directory)

	local highlights = {
		{
			{
				0,
				#tail,
			},
			"Normal",
		},
		{
			{
				#tail + 1,
				#path,
			},
			"FFFDirectory",
		},
	}

	return path, highlights
end

local function decorate_config(config)
	vertical_layout.preview_height = calc_preview_size()

	local utils = require("telescope.utils")

	return vim.tbl_deep_extend('force', config, {
		layout_strategy = aspect_ratio() > 1 and "horizontal" or "vertical",
		layout_config = aspect_ratio() > 1 and horizontal_layout or vertical_layout,
		group_by = config.group_by and {
			field = "filename",
			header_renderer = function(opts, path)
				local tail = utils.path_tail(path)
				local directory = path:gsub("/" .. tail, ""):gsub(vim.fn.getcwd() .. "/", "")

				return {
					{ string.format("  %s ", tail), "Normal" },
					{ directory,                   "FFFDirectory" },
				}
			end,
		} or nil,
	})
end

return {
	"bansheerubber/telescope.nvim",
	dependencies = { { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" } },
	lazy = false,
	config = function()
		local builtin = require("telescope.builtin")
		local telescope = require("telescope")

		require("telescope").setup({
			defaults = {
				prompt_prefix = "  ",
				selection_caret = "  ",
			},
			extensions = {
				file_browser = {
					dir_icon = "",
					dir_icon_hl = "Directory",
					git_icons = {
						untracked = "",
						changed = "",
					},
					display_stat = {},
					grouped = true,
					hidden = { file_browser = true, folder_browser = true },
				},
			},
		})

		telescope.load_extension("file_browser")

		vim.keymap.set("n", "<leader>f", function()
			telescope.extensions.file_browser.file_browser(decorate_config({
				sorting_strategy = "ascending",
				path = "%:p:h",
				select_buffer = true,
			}))
		end)

		vim.keymap.set("n", "<leader>a", "<Cmd>Telescope session-lens search_session<CR>")

		vim.keymap.set({ "n", "v" }, "<leader>t", function()
			builtin.treesitter(decorate_config({
				ignore_symbols = { "var", "namespace" },
				sorting_strategy = "ascending",
			}))
		end)

		vim.keymap.set("n", "<leader>r", function()
			builtin.lsp_references(decorate_config({
				additional_args = { '-l' },
				path_display = { "hidden" },
				sorting_strategy = "ascending",
				group_by = true,
			}))
		end)

		vim.api.nvim_create_autocmd("User", {
			pattern = "TelescopePreviewerLoaded",
			callback = function()
				vim.wo.number = true
			end,
		})
	end,
}
