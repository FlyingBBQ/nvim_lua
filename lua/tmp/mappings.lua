-- General
-- - Search (and replace) the word under the cursor
vim.keymap.set('n', '<leader>r', ':%s/<C-r><C-w>//gc<Left><Left><Left>')
-- - Search (and replace) the selected text
vim.keymap.set('v', '<leader>r', '"hy:%s/<C-r>h//gc<left><left><left>')
-- - Move line up and down in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
-- - Clear lua cache and reload config
vim.keymap.set('n', '<leader>cc', function()
    for name, _ in pairs(package.loaded) do
        if name:match('^cnull') then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
    print("reloaded config")
end)

-- Telescope
vim.keymap.set('', '<C-p>', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>b', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<Leader>m', '<cmd>Telescope git_files<cr>')
vim.keymap.set('n', '<leader>g', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>q', '<cmd>Telescope help_tags<cr>')
vim.keymap.set('n', '<leader>t', function() require("telescope.builtin").grep_string({search = vim.fn.expand("<cword>")}) end)
vim.keymap.set('n', '<leader>f', function() require("telescope.builtin").current_buffer_fuzzy_find() end)
vim.keymap.set('n', '<leader>s', function() require("telescope.builtin").lsp_document_symbols() end)

-- Gitsigns
vim.keymap.set('n', ']c', function() require("gitsigns.actions").next_hunk() end)
vim.keymap.set('n', '[c', function() require("gitsigns.actions").prev_hunk() end)
vim.keymap.set('n', '<leader>hs', function() require("gitsigns").stage_hunk() end)
vim.keymap.set('v', '<leader>hs', function() require("gitsigns").stage_hunk({vim.fn.line("."), vim.fn.line("v")}) end)
vim.keymap.set('n', '<leader>hu', function() require("gitsigns").undo_stage_hunk() end)
vim.keymap.set('n', '<leader>hr', function() require("gitsigns").reset_hunk() end)
vim.keymap.set('v', '<leader>hr', function() require("gitsigns").reset_hunk({vim.fn.line("."), vim.fn.line("v")}) end)
vim.keymap.set('n', '<leader>hR', function() require("gitsigns").reset_buffer() end)
vim.keymap.set('n', '<leader>hp', function() require("gitsigns").preview_hunk() end)
vim.keymap.set('n', '<leader>hS', function() require("gitsigns").stage_buffer() end)
vim.keymap.set('n', '<leader>hU', function() require("gitsigns").reset_buffer_index() end)

vim.cmd([[command! Tb8 :set tabstop=8 shiftwidth=8 softtabstop=8]])
vim.cmd([[command! Tb4 :set tabstop=4 shiftwidth=4 softtabstop=4]])
