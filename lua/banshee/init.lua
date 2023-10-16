require("banshee.packer")
require("banshee.remap")
require("banshee.tabs")
require("banshee.highlight")

require("os")

require('telescope').setup({
	extensions = {
		file_browser = {
			dir_icon = ' ',
			grouped = true,
			hidden = { file_browser = true, folder_browser = true },
		},
	},
})

vim.opt.scrolloff = 20
vim.opt.colorcolumn = "120"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.signcolumn = "yes"
vim.opt.updatetime = 500
