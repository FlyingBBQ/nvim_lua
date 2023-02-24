return {
    -- Visual
    {
        'flyingbbq/darcula',
        -- always load the colorscheme
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.background = 'dark'
            vim.o.termguicolors = true
            vim.cmd([[colorscheme darcula]])

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
        end,
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {
            ensure_installed = {
                'bash',
                'c',
                'comment',
                'css',
                'go',
                'html',
                'javascript',
                'json',
                'lua',
                'python',
                'rst',
                'rust',
                'svelte',
                'yaml',
            },
            highlight = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = 'gnn',
                    node_incremental = 'grn',
                    scope_incremental = 'grc',
                    node_decremental = 'grm',
                },
            },
            indent = {
                enable = true,
                disable = { 'c', 'yaml' },
            }
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
    },

    -- Motion
    {
        'tpope/vim-surround',
        keys = { 'ys', 'cs', 'ds' },
    },

    {
        'godlygeek/tabular',
        cmd = 'Tabularize',
    },

    {
        'numToStr/Comment.nvim',
        config = function ()
            require('Comment').setup()
        end,
    },

    -- Navigation
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        keys = {
            {'<C-p>', '<cmd>Telescope find_files<cr>' },
            { '<leader>b', '<cmd>Telescope buffers<cr>' },
            { '<Leader>m', '<cmd>Telescope git_files<cr>' },
            { '<leader>g', '<cmd>Telescope live_grep<cr>' },
            { '<leader>q', '<cmd>Telescope help_tags<cr>' },
            { '<leader>t', '<cmd>Telescope grep_string({search = vim.fn.expand("<cword>")})<cr>' },
            { '<leader>f', '<cmd>Telescope current_buffer_fuzzy_find<cr>' },
            { '<leader>s', '<cmd>Telescope lsp_document_symbols<cr>' },
        },
        opts = {
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = "close",
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",
                        ["<C-x>"] = false,
                        ["<C-s>"] = "select_horizontal",
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
                    prompt = {'─', '│', ' ', '│', '┌', '┐', '│', '│'},
                    results = {'─', '│', '─', '│', '├', '┤', '┘', '└'},
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
            },
        },
        config = function(_, opts)
            require('telescope').setup(opts)
            require('telescope').load_extension('fzf')
        end
    },

    -- Git
    {
        'tpope/vim-fugitive',
        cmd = 'G',
    },

    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            signs = {
                add = {hl = 'CursorLineNR', text = '+'},
                change = {hl = 'CursorLineNR', text = '~'},
                delete = {hl = 'CursorLineNR', text = '_'},
                topdelete = {hl = 'CursorLineNR', text = '‾'},
                changedelete = {hl = 'CursorLineNR', text = '-'},
                untracked = { hl = 'CusorLineNR', text = '┆' },
            },
        },
    },

    -- Autocomplete
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        config = function()
            -- Automatically install some language servers using mason.
            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'bashls',
                    'clangd',
                    'lua_ls',
                    'pyright',
                    'rust_analyzer',
                }
            })

            -- Use the autocommand 'LspAttach' as on_attach for each server.
            local lsp_cmds = vim.api.nvim_create_augroup('lsp_cmds', {clear = true})
            vim.api.nvim_create_autocmd('LspAttach', {
                group = lsp_cmds,
                desc = 'My global on_attach',
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    -- Mappings.
                    local opts = { buffer = bufnr, silent = true }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<space>n', vim.lsp.buf.rename, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
                    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

                    if client.server_capabilities.completionProvider then
                        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
                    end

                    -- Set autocommands conditional on server_capabilities.
                    if client.server_capabilities.document_highlight then
                        vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = '#3A3A3A' })
                        vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = '#3A3A3A' })
                        vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = '#3A3A3A' })

                        local document_hightlight_group = vim.api.nvim_create_augroup(
                            'LspDocumentHighlight', { clear = true }
                        )
                        vim.api.nvim_create_autocmd("CursorHold", {
                            buffer = 0,
                            callback = vim.lsp.buf.document_highlight,
                            group = document_hightlight_group,
                        })
                        vim.api.nvim_create_autocmd("CursorMoved", {
                            buffer = 0,
                            callback = vim.lsp.buf.clear_references,
                            group = document_hightlight_group,
                        })
                    end
                end
            })

            local lspconfig = require('lspconfig')
            local lsp_defaults = lspconfig.util.default_config

            -- Add client capabilities to the default LSP configuration.
            lsp_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lsp_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            -- Configure LSP servers through default or custom handlers.
            require('mason-lspconfig').setup_handlers({
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function (server_name) -- default handler (optional)
                    lspconfig[server_name].setup {}
                end,

                -- Next, you can provide targeted overrides for specific servers.
                ['clangd'] = function ()
                    lspconfig.clangd.setup {
                        cmd = {
                            'clangd',
                            '--background-index',
                            '--clang-tidy',
                            -- Custom compilers
                            -- '--query-driver=/usr/bin/arm-none-eabi-gcc,/usr/bin/**/clang-*',
                        },
                    }
                end,
                ['lua_ls'] = function ()
                    local runtime_path = vim.split(package.path, ';')
                    table.insert(runtime_path, 'lua/?.lua')
                    table.insert(runtime_path, 'lua/?/init.lua')
                    lspconfig.lua_ls.setup {
                        settings = {
                            Lua = {
                                runtime = {
                                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                                    version = 'LuaJIT',
                                    -- Setup your lua path
                                    path = runtime_path,
                                },
                                diagnostics = {
                                    -- Get the language server to recognize the `vim` global
                                    globals = {'vim'},
                                },
                                workspace = {
                                    -- Make the server aware of Neovim runtime files
                                    library = vim.api.nvim_get_runtime_file("", true),
                                    checkThirdParty = false,
                                },
                                telemetry = {
                                    enable = false,
                                },
                            },
                        },
                    }
                end,
            })

        end,
    },

    {
        'L3MON4D3/LuaSnip',
        version = '<CurrentMajor>.*',
        dependencies = {
            'rafamadriz/friendly-snippets',
            config = function()
                require('luasnip.loaders.from_vscode').lazy_load()
            end,
        },
    },

    {
        'hrsh7th/nvim-cmp',
        version = false, -- last release is way too old
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
        },
        opts = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            return {
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['<C-k>'] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        elseif cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<C-j>'] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                },
                sources = {
                    { name = 'buffer' },
                    { name = 'path' },
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'luasnip' },
                },
            }
        end,
    },

}
