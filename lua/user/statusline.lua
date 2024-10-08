local M = {}

M.colors = {
    active    = "%#StatusLine#",
    inactive  = "%#StatusLineNC#",
    inverse   = "%#StatusInverse#",
    warning   = "%#StatusWarning#",
}

M.nr_of_buffers = function()
    local buffers = 0
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.fn.buflisted(buf) == 1 then
            buffers = buffers + 1
        end
    end
    return '[' .. buffers .. ']'
end

M.get_path = function()
    local path = string.match(vim.api.nvim_buf_get_name(0), "^(.-)[^/]-$")
    local relative = string.match(path, "/home/.-(/.-)$")
    if relative ~= nil and ((vim.api.nvim_win_get_width(0) - 40) > (3 * #relative)) then
        return '~' .. relative
    else
        return ''
    end
end

M.git_status = function()
    local status = vim.b.gitsigns_status
    if status == nil or status == '' then
        return ''
    else
        return '[' .. status .. ']'
    end
end

M.set_active = function(self)
    return table.concat {
        self.colors.inverse,
        self:nr_of_buffers(),
        self.colors.active,
        " :: %t :: ",
        self:git_status(),
        "%h%m%r",
        "%=",
        "%3.p%% ",
        self.colors.inverse,
        "[%3l/%L ::%3.c]",
    }
end

M.set_inactive = function(self)
    return table.concat {
        self.colors.inactive,
        "%=",
        self:get_path(),
        "%t %m",
        "%=",
    }
end

local statusline = setmetatable(M, {
    __call = function(self, mode)
        vim.opt_local.statusline = self["set_" .. mode](self)
    end,
})

local statusline_highlight_group = vim.api.nvim_create_augroup(
    'StatusLine', { clear = true }
)
vim.api.nvim_create_autocmd({"WinEnter", "BufEnter"}, {
    pattern = "*",
    callback = function() statusline('active') end,
    group = statusline_highlight_group,
})
vim.api.nvim_create_autocmd({"WinLeave", "BufLeave"}, {
    pattern = "*",
    callback = function() statusline('inactive') end,
    group = statusline_highlight_group,
})

