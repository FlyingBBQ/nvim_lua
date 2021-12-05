-- Theme
vim.o.background = 'dark'
vim.o.termguicolors = true
vim.cmd('colorscheme darcula')

-- Highlight groups
vim.cmd('highlight link diffAdded String')
vim.cmd('highlight link diffRemoved Comment')
vim.cmd('highlight link diffLine Number')

vim.cmd('highlight! link TSNote Todo')
vim.cmd('highlight! link TSWarning Todo')
vim.cmd('highlight! link TSDanger Error')
vim.cmd('highlight! link TSError Error')
