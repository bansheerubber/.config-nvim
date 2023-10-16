-- configure sane tab options, has to run every damn time a file is opened because vim is architected weird
vim.api.nvim_create_augroup('indent', { clear = true })
vim.api.nvim_create_autocmd({ 'VimEnter', 'BufRead', }, {
	group = 'indent',
	callback = function()
		vim.bo.autoindent  = true
		vim.bo.tabstop     = 2
		vim.bo.shiftwidth  = 2
		vim.bo.softtabstop = 2
		vim.bo.expandtab   = false
	end
})
