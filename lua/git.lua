require('gitsigns').setup {
    signs = {
        add          = {hl = 'CursorLineNR', text = '+'},
        change       = {hl = 'CursorLineNR', text = '~'},
        delete       = {hl = 'CursorLineNR', text = '_'},
        topdelete    = {hl = 'CursorLineNR', text = '‾'},
        changedelete = {hl = 'CursorLineNR', text = '-'},
    },
}
