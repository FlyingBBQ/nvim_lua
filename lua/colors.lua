-- Theme
vim.o.background = 'dark'
vim.o.termguicolors = true
vim.cmd('colorscheme darcula')

-- Highlight groups
vim.cmd('highlight link diffAdded String')
vim.cmd('highlight link diffRemoved Comment')
vim.cmd('highlight link diffLine Number')

