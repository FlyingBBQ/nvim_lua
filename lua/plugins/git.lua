return {
    {
        'tpope/vim-fugitive',
        cmd = 'G',
    },

    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            signs = {
                add          = {text = '+'},
                change       = {text = '~'},
                delete       = {text = '_'},
                topdelete    = {text = '‾'},
                changedelete = {text = '-'},
                untracked    = {text = '┆' },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, {expr=true})

                map('n', '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, {expr=true})

                -- Actions
                map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
                map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
                map('n', '<leader>hS', gs.stage_buffer)
                map('n', '<leader>hu', gs.undo_stage_hunk)
                map('n', '<leader>hR', gs.reset_buffer)
                map('n', '<leader>hp', gs.preview_hunk)
                map('n', '<leader>hb', function() gs.blame_line{full=true} end)

                -- Colors
                vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'CursorLineNR' })
                vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'CursorLineNR' })
                vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { link = 'CursorLineNR' })
                vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'CursorLineNR' })
                vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { link = 'CursorLineNR' })
                vim.api.nvim_set_hl(0, 'GitSignsUntracked', { link = 'CusorLineNR' })
            end
        },
    },
}

