local g = vim.g
local map = vim.api.nvim_set_keymap
local n = { noremap = true }
local ns = { noremap = true, silent = true }
local ne = { noremap = true, expr = true }
local keys = {}

function keys.setup()
    g.mapleader = " "
    g.maplocalleader = ","

    -- the sloth way to send commands
    map('n', ';', ':', {})
    map('n', ';;', ';', n)

    -- find and replace
    map('n', 'S', ':%s//gc<Left><Left><Left>', n)

    -- insert newlines
    map('n', '] ', '<Cmd>lua insert_newline(true)<CR>',  n)
    map('n', '[ ', '<Cmd>lua insert_newline(false)<CR>', n)

    -- move lines
    map('n', ']m', ':move +<CR>',   n)
    map('n', '[m', ':move --<CR>',  n)

    -- clear highlight
    map('n', '<Leader>x', ':noh<CR>', n)

    -- buffer Navigation
    --map('n', '<Leader>b',     ':buffers<CR>:buffer<Space>', n) -- version without telescope
    map('n', '<Leader>b', ':Telescope buffers<CR>', n) -- requires telescope
    map('n', '<Tab>',     ':bn<CR>',                ns)
    map('n', '<S-Tab>',   ':bp<CR>',                ns)
    map('n', '<Leader>q', ':bdelete<CR>',           ns)
    map('n', '<Leader>o', ':edit<Space>',           n)
    -- map('n', '<Leader>h',     ':set hidden<CR>', ns) -- careful: conflict

    -- split navigation
    map('n', '<Leader>h', '<C-w>h', n)
    map('n', '<Leader>j', '<C-w>j', n)
    map('n', '<Leader>k', '<C-w>k', n)
    map('n', '<Leader>l', '<C-w>l', n)

    -- embrace
    map('n', ')',              ':EmbraceNext<CR>',       n)
    map('n', '(',              ':EmbracePrev<CR>',       n)
    map('n', '<LocalLeader>i', ':EmbraceInsertList<CR>', n)
    map('n', '<LocalLeader>a', ':EmbraceAppendList<CR>', n)
    map('n', '<LocalLeader>w', ':EmbraceInsertElem<CR>', n)
    map('n', '<LocalLeader>W', ':EmbraceAppendElem<CR>', n)
    map('n', '<LocalLeader>s', ':EmbraceSlurpBack<CR>',  n)
    map('n', '<LocalLeader>S', ':EmbraceSlurpForth<CR>', n)
    map('n', '<LocalLeader>@', ':EmbraceSplice<CR>',     n)

    -- telescope
    map('n', '<Leader>f', ':Telescope find_files<CR>',  n)
    map('n', '<Leader>r', ':Telescope grep_string<CR>', n)
    map('n', '<Leader>g', ':Telescope live_grep<CR>',   n)
    -- map('n', '<Leader>h', ':Telescope help_tags<CR>',   n) -- careful: conflict

    -- conjure
    map('n', '<LocalLeader>b', '<Cmd>lua vim.g[\'conjure#log#hud#enabled\'] = not vim.g[\'conjure#log#hud#enabled\']<CR>', n)

    -- completion
    map('i', '<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   ne)
    map('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], ne)

    -- lsp
    map('n', 'gd',          '<Cmd>lua vim.lsp.buf.definition()<CR>',                    ns)
    map('n', 'gD',          '<Cmd>lua vim.lsp.buf.declaration()<CR>',                   ns)
    map('n', 'gi',          '<Cmd>lua vim.lsp.buf.implementation()<CR>',                n)
    map('n', 'gr',          '<Cmd>lua vim.lsp.buf.references()<CR>',                    ns)
    map('n', 'gh',          '<Cmd>lua vim.lsp.buf.hover()<CR>',                         ns)
    map('n', '<Leader>e',   '<Cmd>lua vim.diagnostic.open_float({scope="cursor"})<CR>',  ns)
    map('n', '[d',          '<Cmd>lua vim.diagnostic.goto_prev()<CR>',              ns)
    map('n', ']d',          '<Cmd>lua vim.diagnostic.goto_next()<CR>',              ns)
end

return keys
