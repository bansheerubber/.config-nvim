vim.g.mapleader       = ','

-- toggle relative line numbers
vim.wo.number         = true
vim.wo.relativenumber = true -- default to relative numbers on
vim.keymap.set("n", "<C-L><C-L>", function()
	vim.wo.relativenumber = not vim.wo.relativenumber
end)

vim.keymap.set("n", "`", "i")
vim.keymap.set("v", "`", "<ESC>i")

-- word skip on arrow keys
vim.keymap.set("n", "<C-Left>", "b")
vim.keymap.set("n", "<C-Right>", "w")

-- window management keybinds
vim.keymap.set({ "n", "v", }, "<C-q>", "<C-w>", { noremap = true })
vim.keymap.set("i", "<C-q>", "<C-C><C-w>", { noremap = true })

-- delete backward one word
vim.keymap.set("i", "<C-w>", [[<C-\><C-o>"_db]], { noremap = true })
vim.keymap.set("n", "<C-w>", [["_db]], { noremap = true })

-- ctrl+s to save
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<C-C>w<CR>")
vim.keymap.set("v", "<C-s>", "<C-O>w<CR>")

-- harpoon maps
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.keymap.set("n", "<C-a>", function()
	print("harpooned " .. vim.api.nvim_buf_get_name(0))
	mark.add_file()
end)
vim.keymap.set("n", "<C-b>", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)
vim.keymap.set("n", "<leader>5", function() ui.nav_file(5) end)
vim.keymap.set("n", "<leader>6", function() ui.nav_file(6) end)
vim.keymap.set("n", "<leader>7", function() ui.nav_file(7) end)
vim.keymap.set("n", "<leader>8", function() ui.nav_file(8) end)
vim.keymap.set("n", "<leader>9", function() ui.nav_file(9) end)
vim.keymap.set("n", "<leader>0", function() ui.nav_file(0) end)

-- undotree stuff
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- keep terminal centered when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- make paste behave normally
vim.keymap.set("x", "p", [["_dP]])

-- yank into OS clipboard
vim.keymap.set("n", "<leader>y", [["+y]])
vim.keymap.set("v", "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- make delete behave normally
vim.keymap.set("n", "<leader>d", [["_d]])
vim.keymap.set("v", "<leader>d", [["_d]])

-- disable Ex mode
vim.keymap.set("n", "Q", "<nop>")

-- start replacing word we're currently on
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
