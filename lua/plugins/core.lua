return {
    {
        'tpope/vim-surround',
        keys = { 'ys', 'cs', 'ds' },
    },

    {
        'godlygeek/tabular',
        cmd = 'Tabularize',
    },

    {
        'numToStr/Comment.nvim',
        config = function ()
            require('Comment').setup()
        end,
    },
}

