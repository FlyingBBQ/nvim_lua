return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- Visual
    use 'flyingbbq/darcula'

    -- Navigation
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
        }
    }
end)
