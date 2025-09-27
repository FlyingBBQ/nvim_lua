-- Search (and replace) the word under the cursor
vim.keymap.set('n', '<leader>r', ':%s/<C-r><C-w>//gc<Left><Left><Left>')

-- Search (and replace) the selected text
vim.keymap.set('v', '<leader>r', '"hy:%s/<C-r>h//gc<left><left><left>')

-- Clear search
vim.keymap.set('n', '<leader>l', '<Cmd>nohlsearch<CR>')

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

vim.api.nvim_create_user_command("TW", function(opts)
    local width = tonumber(opts.args)
    if width and width > 0 then
        vim.opt.tabstop = width
        vim.opt.shiftwidth = width
        vim.opt.softtabstop = width
        vim.notify("Tab width set to " .. width, vim.log.levels.INFO)
    else
        vim.notify("Please provide a valid number", vim.log.levels.ERROR)
    end
end, { nargs = 1, desc = "Set tab width to specified number" })
