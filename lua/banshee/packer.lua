vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use('folke/flash.nvim')
end)
