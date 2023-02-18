local nvim_lsp = require('lspconfig')
local luasnip = require('luasnip')
local cmp = require('cmp')

-- Create a custom on_attach function.
local on_attach = function(client, bufnr)
    -- Local options
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches.
local servers = { "pyright", "rust_analyzer", "bashls" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

-- Separate setup of LSPs with a more custom configuration.
nvim_lsp.clangd.setup {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        -- Custom compilers
        -- "--query-driver=/usr/bin/arm-none-eabi-gcc,/usr/bin/**/clang-*",
    },
    on_attach = on_attach,
    capabilities = capabilities,
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
nvim_lsp.lua_ls.setup {
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
            },
            telemetry = {
                enable = false,
            },
        },
    },
}

-- Setup for nvim-cmp (completion).
cmp.setup {
    snippet = {
        expand = function(args)
            -- Use luasnip as snippet engine for nvim-cmp
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
        ['<C-k>'] = function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            elseif cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
        ['<C-j>'] = function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
    },
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
    },
}

