return {
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

                    if client.server_capabilities.completionProvider then
                        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
                    end

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
}

