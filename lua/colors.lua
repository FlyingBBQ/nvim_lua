-- Theme
vim.o.background = 'dark'
vim.o.termguicolors = true
vim.cmd('colorscheme darcula')

-- Highlight groups
vim.api.nvim_set_hl(0, 'diffAdded', { link = "String" })
vim.api.nvim_set_hl(0, 'diffAdded', { link = "String" })
vim.api.nvim_set_hl(0, 'diffRemoved', { link = "Comment" })
vim.api.nvim_set_hl(0, 'diffLine', { link = "Number" })

vim.api.nvim_set_hl(0, 'TSNote', { link = "Todo" })
vim.api.nvim_set_hl(0, 'TSWarning', { link = "Todo" })
vim.api.nvim_set_hl(0, 'TSDanger', { link = "Error" })
vim.api.nvim_set_hl(0, 'TSError', { link = "Error" })

vim.api.nvim_set_hl(0, 'StatusInverse', { link = "TermCursor" })
vim.api.nvim_set_hl(0, 'StatusWarning', { link = "Visual" })
