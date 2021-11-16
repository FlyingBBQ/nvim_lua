-- General
vim.api.nvim_set_keymap('n', '_', ':<C-u>nohlsearch<cr>', {noremap = true})

-- Telescope
vim.api.nvim_set_keymap('', '<C-p>', '<cmd>Telescope find_files<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>m', '<cmd>Telescope git_files<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>Telescope live_grep<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>Telescope help_tags<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>f', ':<C-u>lua require("telescope.builtin").current_buffer_fuzzy_find()<cr>', {noremap = true})
