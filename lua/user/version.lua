-- Minimum version for config compatibility
if vim.fn.has("nvim-0.11") == 0 then
    vim.notify("Requires Neovim 0.11+", vim.log.levels.ERROR)
    return
end
