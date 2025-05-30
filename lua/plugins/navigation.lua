return {
    {
        "ibhagwan/fzf-lua",
        config = function()
            local fzf = require('fzf-lua')
            fzf.setup({
                defaults = {
                    file_icons = false,
                    git_icons = true,
                    color_icons = true,
                },
                winopts = {
                    width = 100,
                    border = "single",
                    preview = {
                        border = "single",
                        vertical = "up:40%",
                        layout = "vertical",
                    },
                }
            })
            local shared_winopts = {
                row = 0.50,
                height = 15,
                preview = {
                    hidden = true,
                }
            }
            -- Browse
            vim.keymap.set('n', '<C-p>', function() fzf.files({ winopts = shared_winopts }) end, {})
            vim.keymap.set('n', '<leader>b', function() fzf.buffers({ winopts = shared_winopts }) end, {})
            vim.keymap.set('n', '<leader>m', function() fzf.git_files({ winopts = shared_winopts }) end, {})
            -- Search
            vim.keymap.set('n', '<leader>g', function() fzf.live_grep() end, {})
            vim.keymap.set('n', '<leader>t', function() fzf.grep_cword() end, {})
            vim.keymap.set('n', '<leader>f', function() fzf.lgrep_curbuf() end, {})
            -- LSP
            vim.keymap.set('n', '<leader>s', function() fzf.lsp_document_symbols() end, {})
            -- Help
            vim.keymap.set('n', '<leader>q', function() fzf.helptags() end, {})
            vim.keymap.set('n', '<leader>v', function() fzf.builtin() end, {})
        end
    },
}

