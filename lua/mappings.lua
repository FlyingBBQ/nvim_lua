-- General
-- - Search (and replace) the word under the cursor
vim.api.nvim_set_keymap('n', '<leader>r', ':%s/<C-r><C-w>//gc<Left><Left><Left>', {noremap = true})
-- - Search (and replace) the selected text
vim.api.nvim_set_keymap('v', '<leader>r', '"hy:%s/<C-r>h//gc<left><left><left>', {noremap = true})
-- - Move line up and down in visual mode
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", {noremap = true})
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", {noremap = true})

-- Telescope
vim.api.nvim_set_keymap('', '<C-p>', '<cmd>Telescope find_files<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>m', '<cmd>Telescope git_files<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>Telescope live_grep<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>Telescope help_tags<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>f', ':<C-u>lua require("telescope.builtin").current_buffer_fuzzy_find()<cr>', {noremap = true})

-- Gitsigns
vim.api.nvim_set_keymap('n', ']c', '<cmd>lua require"gitsigns.actions".next_hunk()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '[c', '<cmd>lua require"gitsigns.actions".prev_hunk()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>hs', '<cmd>lua require"gitsigns".stage_hunk()<CR>', {noremap = true})
vim.api.nvim_set_keymap('v', '<leader>hs', '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>hu', '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>hr', '<cmd>lua require"gitsigns".reset_hunk()<CR>', {noremap = true})
vim.api.nvim_set_keymap('v', '<leader>hr', '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>hR', '<cmd>lua require"gitsigns".reset_buffer()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>hp', '<cmd>lua require"gitsigns".preview_hunk()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>hS', '<cmd>lua require"gitsigns".stage_buffer()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>hU', '<cmd>lua require"gitsigns".reset_buffer_index()<CR>', {noremap = true})
