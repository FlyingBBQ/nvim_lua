local function nr_of_buffers()
    return '[' .. #(vim.api.nvim_list_bufs()) .. ']'
end

local function get_path()
    local path = string.match(vim.api.nvim_buf_get_name(0), "^(.-)[^/]-$")
    local relative = string.match(path, "/home/.-(/.-)$")
    if relative and ((vim.api.nvim_win_get_width(0) - 40) > (3 * #relative)) then
        return '~' .. relative
    else
        return ''
    end
end

local function git_status()
    local status = vim.b.gitsigns_status
    if (status == nil or status == '') then
        return ''
    else
        return '[' .. status .. ']'
    end
end

function status_line()
    return table.concat {
        nr_of_buffers(),
        " :: %t :: ",
        git_status(),
        "%h%m%r",
        "%=%<", -- center
        get_path(),
        "%=", -- right side
        "%3.p%% ",
        "[%3l/%L ::%3.c]",
    }
end

vim.o.statusline = "%!luaeval('status_line()')"
