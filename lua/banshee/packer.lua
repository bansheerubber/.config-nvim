vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use('wbthomason/packer.nvim')

	use({
		'nvim-telescope/telescope.nvim',
		tag = '0.1.3',
		-- or                            , branch = '0.1.x',
		requires = { { 'nvim-lua/plenary.nvim' } }
	})

	use({
		'nvim-telescope/telescope-frecency.nvim',
		config = function()
			require('telescope').load_extension 'frecency'
		end,
	})

	use({
		'nvim-telescope/telescope-file-browser.nvim',
		requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
		config = function()
			require('telescope').load_extension 'file_browser'
		end,
	})

	use({
		'rmagatti/auto-session',
		config = function()
			require('auto-session').setup {
				log_level = 'error',
				auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
			}
		end
	})

	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
	use('nvim-treesitter/playground')

	use('tpope/vim-sleuth')

	use('nvim-lua/plenary.nvim')
	use('ThePrimeagen/harpoon')
	use('mbbill/undotree')

	use('/home/me/Projects/bansheescheme.nvim')
	-- use('/home/me/Projects/better-tabs.nvim/')

	use({
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' },
			{ 'williamboman/mason.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-nvim-lua' },

			-- Snippets
			{ 'L3MON4D3/LuaSnip' },
			{ 'rafamadriz/friendly-snippets' },
		}
	})

	use({
		'zbirenbaum/copilot-cmp',
		after = { 'copilot.lua' },
		config = function()
			require('copilot_cmp').setup()
		end
	})

	use({
		'zbirenbaum/copilot.lua',
		cmd = 'Copilot',
		event = 'InsertEnter',
		config = function()
			require('copilot').setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	})

	use({
		'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
		config = function()
			require('lsp_lines').setup()
		end,
	})

	use({ '/home/me/Projects/catppuccin.nvim', as = 'catppuccin' })

	use('norcalli/nvim-colorizer.lua')

	use('lewis6991/gitsigns.nvim')
	use('nvim-lualine/lualine.nvim')

	use('mfussenegger/nvim-dap')
	use('leoluz/nvim-dap-go')
	use('rcarriga/nvim-dap-ui')
	use('mxsdev/nvim-dap-vscode-js')
	use({
		'microsoft/vscode-js-debug',
		opt = true,
		run = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out'
	})

	use({
		'klen/nvim-config-local',
		config = function()
			require('config-local').setup({
				-- Default options (optional)

				-- Config file patterns to load (lua supported)
				config_files = { '.nvim.lua', '.nvimrc', '.exrc' },

				-- Where the plugin keeps files data
				hashfile = vim.fn.stdpath('data') .. '/config-local',

				autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
				commands_create = true,   -- Create commands (ConfigLocalSource, ConfigLocalEdit, ConfigLocalTrust, ConfigLocalIgnore)
				silent = false,           -- Disable plugin messages (Config loaded/ignored)
				lookup_parents = false,   -- Lookup config files in parent directories
			})
		end
	})
end)
