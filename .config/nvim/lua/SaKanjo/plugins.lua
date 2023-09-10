local status, packer = pcall(require, 'packer')
if (not status) then
  return print('Packer is not installed')
end

vim.cmd [[packadd packer.nvim]]

packer.startup({ function(use)
  use "b0o/schemastore.nvim"
  use '0oAstro/dim.lua'
  use 'AndrewRadev/sideways.vim'
  use 'AndrewRadev/splitjoin.vim'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'L3MON4D3/LuaSnip'
  use 'RRethy/nvim-treesitter-endwise'
  use 'RRethy/vim-illuminate'
  use 'airblade/vim-rooter'
  use 'akinsho/bufferline.nvim'
  use 'akinsho/toggleterm.nvim'
  use 'andymass/vim-matchup'
  use 'ckolkey/ts-node-action'
  use 'danymat/neogen'
  use 'easymotion/vim-easymotion'
  use 'farmergreg/vim-lastplace'
  use 'folke/lsp-colors.nvim'
  use 'folke/todo-comments.nvim'
  use 'folke/tokyonight.nvim'
  use 'folke/trouble.nvim'
  use 'folke/which-key.nvim'
  use 'github/copilot.vim'
  use 'glepnir/lspsaga.nvim'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-calc'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'
  use 'ilyachur/cmake4vim'
  use 'jayp0521/mason-null-ls.nvim'
  use 'jghauser/mkdir.nvim'
  use 'jiangmiao/auto-pairs'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  use 'junegunn/vim-easy-align'
  use 'kana/vim-textobj-entire'
  use 'kana/vim-textobj-user'
  use 'leafOfTree/vim-vue-plugin'
  use 'leoluz/nvim-dap-go'
  use 'lervag/vimtex'
  use 'lewis6991/gitsigns.nvim'
  use 'lewis6991/impatient.nvim'
  use 'mfussenegger/nvim-dap'
  use 'mfussenegger/nvim-dap-python'
  use 'mg979/vim-visual-multi'
  use 'nelstrom/vim-visual-star-search'
  use 'neovim/nvim-lspconfig'
  use 'numToStr/Comment.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/playground'
  use 'preservim/vim-markdown'
  use 'ray-x/lsp_signature.nvim'
  use 'rcarriga/nvim-dap-ui'
  use 'rhysd/clever-f.vim'
  use 'saadparwaiz1/cmp_luasnip'
  use 'sickill/vim-pasta'
  use 'svermeulen/vim-cutlass'
  use 'svermeulen/vim-subversive'
  use 'thinca/vim-textobj-between'
  use 'tommcdo/vim-exchange'
  use 'tpope/vim-abolish'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-surround'
  use 'vim-test/vim-test'
  use 'wbthomason/packer.nvim'
  use 'whatyouhide/vim-textobj-xmlattr'
  use 'williamboman/mason-lspconfig.nvim'
  use 'williamboman/mason.nvim'
  use 'windwp/nvim-ts-autotag'
  use 'xuhdev/vim-latex-live-preview'
  use { 'iamcco/markdown-preview.nvim', run = function() vim.fn['mkdp#util#install']() end }
  use { 'michaelb/sniprun', run = 'bash ./install.sh' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' } } }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  } })
