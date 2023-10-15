return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
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
                    prompt = {'─', '│', ' ', '│', '┌', '┐', '│', '│'},
                    results = {'─', '│', '─', '│', '├', '┤', '┘', '└'},
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
}

