vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	use 'wbthomason/packer.nvim'

	-- Colors
	use { 'norcalli/nvim-colorizer.lua', opt = true }

	-- Colorscheme
	use { 'ErichDonGubler/vim-sublime-monokai', opt = true }

	-- Completion
	use { 'nvim-lua/completion-nvim', opt = true, requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}} }
	use { 'steelsojka/completion-buffers', opt = true }
	use { 'jiangmiao/auto-pairs', opt = true }

	-- Git
	use { 'tpope/vim-fugitive', opt = true }
	use { 'airblade/vim-gitgutter', opt = true }

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
