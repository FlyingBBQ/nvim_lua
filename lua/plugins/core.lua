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
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        lazy = false,
    },
}

