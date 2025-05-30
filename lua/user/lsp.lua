-- :h lsp-config
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }

    vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'grd', vim.lsp.buf.definition, opts)
  end,
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    callback = function()
        for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_config(winid).zindex then
                -- Don't open diagnostic window if there is already
                -- a floating window visible.
                return
            end
        end
        vim.diagnostic.open_float({
            scope = "cursor",
            focusable = false,
            close_events = {
                "CursorMoved",
                "CursorMovedI",
                "BufHidden",
                "InsertCharPre",
                "WinLeave",
            },
        })
    end
})

-- Enable configured language servers
-- Server configurations are located in lsp/*.lua files
vim.lsp.enable('bash_ls')
vim.lsp.enable('clangd')
vim.lsp.enable('lua_ls')
vim.lsp.enable('rust_analyzer')
