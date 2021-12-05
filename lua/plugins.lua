return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- Visual
    use 'flyingbbq/darcula'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- Navigation
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
        }
    }

    -- Git
    use 'tpope/vim-fugitive'
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
    }

    -- Autocomplete
    use 'neovim/nvim-lspconfig'
end)
