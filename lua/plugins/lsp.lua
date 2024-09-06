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

                    if client ~= nil then
                        -- Capabilities.
                        if client.server_capabilities.completionProvider then
                            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
                        end
                        if client.server_capabilities.definitionProvider then
                            vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
                        end

                        -- Mappings.
                        local opts = { buffer = bufnr, silent = true }
                        if client.supports_method('textDocument/declaration') then
                            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                        end
                        if client.supports_method('textDocument/definition') then
                            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                        end
                        if client.supports_method('textDocument/implementation') then
                            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                        end
                        if client.supports_method('textDocument/references') then
                            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                        end
                        if client.supports_method('textDocument/signatureHelp') then
                            vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, opts)
                        end
                        if client.supports_method('textDocument/rename') then
                            vim.keymap.set('n', '<space>n', vim.lsp.buf.rename, opts)
                        end
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

            vim.api.nvim_create_autocmd({ "CursorHold" }, {
                pattern = "*",
                callback = function()
                    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
                        if vim.api.nvim_win_get_config(winid).zindex then
                            return
                        end
                    end
                    vim.diagnostic.open_float({
                        scope = "cursor",
                        focusable = false,
                        close_events = {
                            "CursorMoved",
                            "CursorMovedI",
                            "BufHidden",
                            "InsertCharPre",
                            "WinLeave",
                        },
                    })
                end
            })

        end,
    },
}

