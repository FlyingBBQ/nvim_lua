vim.g.mapleader = vim.keycode("<space>")

-- General
vim.o.clipboard = 'unnamedplus'
vim.o.completeopt = 'menuone,noselect'
vim.o.mouse = 'a'
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'

-- Colorscheme
vim.o.background = 'dark'
vim.o.termguicolors = true

-- Sidebar
vim.o.cursorline = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.showcmd = true

-- Display
vim.o.scrolloff = 2
vim.o.sidescrolloff = 5
vim.o.updatetime = 500
vim.o.lazyredraw = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split'

-- Tabs
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

-- Undo
vim.o.undodir = os.getenv("HOME") .. '/.local/share/nvim/undodir'
vim.o.undofile = true
