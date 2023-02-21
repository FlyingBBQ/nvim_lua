-- Search (and replace) the word under the cursor
vim.keymap.set('n', '<leader>r', ':%s/<C-r><C-w>//gc<Left><Left><Left>')

-- Search (and replace) the selected text
vim.keymap.set('v', '<leader>r', '"hy:%s/<C-r>h//gc<left><left><left>')

-- Move line up and down in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Clear lua cache and reload config
vim.keymap.set('n', '<leader>cc', function()
    for name, _ in pairs(package.loaded) do
        if name:match('^cnull') then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
    print("reloaded config")
end)

vim.cmd([[command! Tb8 :set tabstop=8 shiftwidth=8 softtabstop=8]])
vim.cmd([[command! Tb4 :set tabstop=4 shiftwidth=4 softtabstop=4]])
