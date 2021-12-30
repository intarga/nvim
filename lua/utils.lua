function insert_newline(after)
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_put({""}, "l", after, false)
    if not after then pos[1] = pos[1]+1 end
    vim.api.nvim_win_set_cursor(0, pos)
end
