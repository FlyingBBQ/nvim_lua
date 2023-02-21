return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- Visual
    use 'flyingbbq/darcula'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use '~/code/hindsight'
    use 'rktjmp/lush.nvim'
    use 'nvim-treesitter/playground'

    -- Motion
    use 'tpope/vim-surround'
    use 'godlygeek/tabular'

    -- Comment
    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    }

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
    use 'L3MON4D3/LuaSnip'
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip'
        },
    }

    -- Markdown
    use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' }
end)
