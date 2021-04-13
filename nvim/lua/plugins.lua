local cmd = vim.cmd

cmd [[packadd! packer.nvim]]
cmd [[command! PackerInstall lua require('plugins').install()]]
cmd [[command! PackerUpdate  lua require('plugins').update()]]
cmd [[command! PackerSync    lua require('plugins').sync()]]
cmd [[command! PackerClean   lua require('plugins').clean()]]
cmd [[command! PackerCompile lua require('plugins').compile()]]

-- Colors
cmd [[packadd! nvim-colorizer.lua]]

-- Colorscheme
cmd [[packadd! vim-sublime-monokai]]

-- Completion
cmd [[packadd! nvim-compe]]
cmd [[packadd! vim-vsnip]]
cmd [[packadd! vim-vsnip-integ]]
cmd [[packadd! delimitMate]]
cmd [[packadd! vim-closetag]]

-- Tree-sitter
cmd [[packadd! nvim-treesitter]]

-- Finder
cmd [[packadd! LeaderF]]
cmd [[packadd! popup.nvim]]
cmd [[packadd! plenary.nvim]]
cmd [[packadd! telescope.nvim]]

-- Formatting
cmd [[packadd! vim-easy-align]]

-- Git
cmd [[packadd! vim-fugitive]]
cmd [[packadd! vim-gitgutter]]

-- Interface
cmd [[packadd! indent-blankline.nvim]]

-- LSP
cmd [[packadd! nvim-lspconfig]]
cmd [[packadd! lsp-status.nvim]]

-- Tabs
cmd [[packadd! barbar.nvim]]

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'

	-- Colors
	use { 'norcalli/nvim-colorizer.lua', opt = true }

	-- Colorscheme
	use { 'ErichDonGubler/vim-sublime-monokai', opt = true }

	-- Completion
	use { 'hrsh7th/nvim-compe', opt = true, requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}} }
	use { 'Raimondi/delimitMate', opt = true }
	use { 'alvan/vim-closetag', opt = true}

	-- Git
	use { 'tpope/vim-fugitive', opt = true }
	use { 'airblade/vim-gitgutter', opt = true }

	-- Interface
	use { 'lukas-reineke/indent-blankline.nvim', branch = 'lua', opt = true }

	-- Finder
	use { 'Yggdroot/LeaderF', opt = true}
	use { 'nvim-telescope/telescope.nvim', opt = true, requires = { {'nvim-lua/popup.nvim', opt = true}, {'nvim-lua/plenary.nvim', opt = true} } }

	-- Formatting
	use { 'junegunn/vim-easy-align', opt = true }

	-- LSP
	use { 'neovim/nvim-lspconfig', opt = true }
	use { 'nvim-lua/lsp-status.nvim', opt = true }

	-- Tabs
	use { 'romgrk/barbar.nvim', opt = true }

	-- Tree-sitter
	use { 'nvim-treesitter/nvim-treesitter', opt = true }
end)
