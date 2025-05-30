---@type vim.lsp.Config
return {
    cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        -- Custom compilers
        -- '--query-driver=/usr/bin/arm-none-eabi-gcc,/usr/bin/**/clang-*',
    },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    root_markers = {
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac', -- AutoTools
        '.git',
    },
}
