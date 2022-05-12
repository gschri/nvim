vim.cmd [[packadd packer.nvim]]

vim.cmd [[augroup Packer_user_config]]
vim.cmd [[autocmd!]]
vim.cmd [[autocmd BufWritePost plugins.lua source <afile> | PackerCompile ]]
vim.cmd [[augroup END]]

return require('packer').startup(function()
	-- Packer plugin manager
	use 'wbthomason/packer.nvim'
  -- Gitsigns
  use 'lewis6991/gitsigns.nvim'
	-- Colorscheme
	use 'folke/tokyonight.nvim'
  -- Plugin for making init.lua development easier
  use 'folke/lua-dev.nvim'
	-- Collection of configurations for the LSP client
	use {
		'williamboman/nvim-lsp-installer',
		'neovim/nvim-lspconfig'
	}
	-- Lightweight lsp plugin
	use 'tami5/lspsaga.nvim'
  -- Lsp source for filesystem paths
  use 'hrsh7th/cmp-path'
  -- Autocompletion
  use 'hrsh7th/nvim-cmp' 
  -- Lsp source form nvim-cmp
  use 'hrsh7th/cmp-nvim-lsp' 
  -- Snippets source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip'
  -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-buffer'
  -- Snippets plugin
  use 'L3MON4D3/LuaSnip'
	-- Syntax highlighting
	use 'nvim-treesitter/nvim-treesitter'
  -- Autopairs for nvim
  use 'windwp/nvim-autopairs'
	-- Fuzzy finder
	use {
  		'nvim-telescope/telescope.nvim',
  		requires = { {'nvim-lua/plenary.nvim'} }
	}
  -- Which Key
  use 'folke/which-key.nvim'
	-- Statusline
	use {
  		'nvim-lualine/lualine.nvim',
		-- Web icons support
  		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	-- File Explorer
	use {
		'kyazdani42/nvim-tree.lua',
		-- Web icons support
  		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	-- Comments
	use {
    		'numToStr/Comment.nvim',
	    	config = function()
			require('Comment').setup()
	    	end
	}

end)
