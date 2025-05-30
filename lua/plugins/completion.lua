return {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = 'enter' },
        completion = {
            documentation = { auto_show = false },
            list = {
                selection = {
                    preselect = true,
                    auto_insert = false,
                }
            },
        },
        fuzzy = {
            implementation = "prefer_rust_with_warning",
            use_frecency = false,
            use_proximity = false,
        }
    }
}
