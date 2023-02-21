return {
    -- Visual
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
                "bash",
                "c",
                "comment",
                "css",
                "go",
                "html",
                "javascript",
                "json",
                "lua",
                "python",
                "rst",
                "rust",
                "svelte",
                "yaml",
            },
            highlight = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
            indent = {
                enable = true,
                disable = { "c", "yaml" },
            }
        },
    },

    -- Motion
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

    -- Navigation
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        keys = {
            {'<C-p>', '<cmd>Telescope find_files<cr>' },
            { '<leader>b', '<cmd>Telescope buffers<cr>' },
            { '<Leader>m', '<cmd>Telescope git_files<cr>' },
            { '<leader>g', '<cmd>Telescope live_grep<cr>' },
            { '<leader>q', '<cmd>Telescope help_tags<cr>' },
            { '<leader>t', '<cmd>Telescope grep_string({search = vim.fn.expand("<cword>")})<cr>' },
            { '<leader>f', '<cmd>Telescope current_buffer_fuzzy_find<cr>' },
            { '<leader>s', '<cmd>Telescope lsp_document_symbols<cr>' },
        },
        opts = {
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = "close",
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",
                        ["<C-x>"] = false,
                        ["<C-s>"] = "select_horizontal",
                    }
                },
                sorting_strategy = "ascending",
                layout_strategy = "center",
                layout_config = {
                    height = 15,
                    width = 100,
                    preview_cutoff = 1,
                    prompt_position = "top",
                },
                winblend = 10,
                prompt_prefix = "> ",
                selection_caret = "> ",
                entry_prefix = "  ",
                border = true,
                borderchars = {
                    { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
                    prompt = {"─", "│", " ", "│", "┌", "┐", "│", "│"},
                    results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
                    preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
                },
            },
            pickers = {
                find_files = {
                    previewer = false,
                },
                git_files = {
                    previewer = false,
                },
                buffers = {
                    previewer = false,
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            },
        },
        config = function(_, opts)
            require('telescope').setup(opts)
            require('telescope').load_extension('fzf')
        end
    },

    -- Git
    {
        'tpope/vim-fugitive',
        cmd = 'G',
    },

    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            signs = {
                add = {hl = 'CursorLineNR', text = '+'},
                change = {hl = 'CursorLineNR', text = '~'},
                delete = {hl = 'CursorLineNR', text = '_'},
                topdelete = {hl = 'CursorLineNR', text = '‾'},
                changedelete = {hl = 'CursorLineNR', text = '-'},
                untracked = { hl = 'CusorLineNR', text = '┆' },
            },
        },
    },

}
