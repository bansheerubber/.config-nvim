vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-q>", 'copilot#Accept("<C-R>")', { expr = true, silent = true })

vim.g.copilot_workspace_folders = {
	"/home/me/Projects",
}
