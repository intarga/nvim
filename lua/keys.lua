local g = vim.g
local map = vim.api.nvim_set_keymap
local n = { noremap = true }
local ns = { noremap = true, silent = true }
local ne = { noremap = true, expr = true }
local keys = {}

function keys.setup()
    g.mapleader = " "

    -- the sloth way to send commands
    map('n', ';', ':', {})
    map('n', ';;', ';', n)

    -- find and replace
    map('n', 'S', ':%s//gc<Left><Left><Left>', n)

    -- clear highlight
    map('n', '<Leader>x', ':noh<CR>', n)

    -- buffer Navigation
    --map('n', '<Leader>b',     ':buffers<CR>:buffer<Space>', n) -- version without fzf plugin
    map('n', '<Leader>b',     ':Buffers<CR>',               n) -- requires fzf
    map('n', '<Tab>',         ':bn<CR>',                    ns)
    map('n', '<S-Tab>',       ':bp<CR>',                    ns)
    map('n', '<Leader>q',     ':bdelete<CR>', 	        	ns)
    map('n', '<Leader>o',     ':edit<Space>', 		        n)
    map('n', '<Leader>h',     ':set hidden<CR>', 		    ns)

    -- fzf todo: Gfiles support?
    map('n', '<Leader>f',     ':Files<Space>.<CR>', 	    n)
    map('n', '<Leader>r',     ':Rg<Space><C-R><C-W><CR>',   n)

    -- completion
    map('i', '<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],	        ne)
    map('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]],	    ne)

    -- lsp
    map('n', 'gd',          '<Cmd>lua vim.lsp.buf.definition()<CR>',            		    ns)
    map('n', 'gD',          '<Cmd>lua vim.lsp.buf.declaration()<CR>', 		                ns)
    map('n', 'gi',          '<Cmd>lua vim.lsp.buf.implementation()<CR>', 		            n)
    map('n', 'gr',          '<Cmd>lua vim.lsp.buf.references()<CR>', 		                ns)
    map('n', 'gh',          '<Cmd>lua vim.lsp.buf.hover()<CR>', 		                    ns)
    map('n', '<Leader>e',   '<Cmd>lua vim.lsp.buf.diagnostic.show_line_diagnostics()<CR>',  ns)
    map('n', '[d',          '<Cmd>lua vim.lsp.buf.diagnostic.goto_prev()<CR>', 		        ns)
    map('n', ']d',          '<Cmd>lua vim.lsp.buf.diagnostic.goto_next()<CR>', 		        ns)
end

return keys
