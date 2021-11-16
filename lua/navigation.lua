require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = require('telescope.actions').close,
                ["<C-j>"] = require('telescope.actions').move_selection_next,
                ["<C-k>"] = require('telescope.actions').move_selection_previous,
                ["<C-x>"] = false,
                ["<C-s>"] = require('telescope.actions').select_horizontal,
            }
        },
        sorting_strategy = "ascending",
        layout_strategy = "center",
        layout_config = {
            height = 15,
            width = 100,
            preview_cutoff = 1,
            prompt_position = "top",
        },
        winblend = 10,
        prompt_prefix = "> ",
        selection_caret = "> ",
        entry_prefix = "  ",
        border = true,
        borderchars = {
            { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
            prompt = {"─", "│", " ", "│", "┌", "┐", "│", "│"},
            results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
            preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        },
    },
    pickers = {
        find_files = {
            previewer = false,
        },
        git_files = {
            previewer = false,
        },
        buffers = {
            previewer = false,
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
}
require('telescope').load_extension('fzf')
