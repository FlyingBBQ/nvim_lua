return {
    {
        'flyingbbq/darcula',
        -- always load the colorscheme
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.background = 'dark'
            vim.o.termguicolors = true
            vim.cmd([[colorscheme darcula]])

            vim.api.nvim_set_hl(0, 'diffAdded', { link = "String" })
            vim.api.nvim_set_hl(0, 'diffAdded', { link = "String" })
            vim.api.nvim_set_hl(0, 'diffRemoved', { link = "Comment" })
            vim.api.nvim_set_hl(0, 'diffLine', { link = "Number" })

            vim.api.nvim_set_hl(0, 'TSNote', { link = "Todo" })
            vim.api.nvim_set_hl(0, 'TSWarning', { link = "Todo" })
            vim.api.nvim_set_hl(0, 'TSDanger', { link = "Error" })
            vim.api.nvim_set_hl(0, 'TSError', { link = "Error" })

            vim.api.nvim_set_hl(0, 'StatusInverse', { link = "TermCursor" })
            vim.api.nvim_set_hl(0, 'StatusWarning', { link = "Visual" })
        end,
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {
            ensure_installed = {
                'bash',
                'c',
                'comment',
                'css',
                'go',
                'html',
                'javascript',
                'json',
                'lua',
                'python',
                'rst',
                'rust',
                'svelte',
                'yaml',
            },
            highlight = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = 'gnn',
                    node_incremental = 'grn',
                    scope_incremental = 'grc',
                    node_decremental = 'grm',
                },
            },
            indent = {
                enable = true,
                disable = { 'c', 'yaml' },
            }
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
    },
}

