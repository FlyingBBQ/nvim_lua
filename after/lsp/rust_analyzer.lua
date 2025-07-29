---@type vim.lsp.Config
return {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", "Cargo.lock", "build.rs" },
    -- See more: https://rust-analyzer.github.io/book/configuration.html
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
                features = "all",
                allTargets = true,
            },
            rustfmt = { enable = true },
            diagnostics = {
                styleLints = { enable = true }
            },
        },
    },
}
