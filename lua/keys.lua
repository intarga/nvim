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

    -- fzf
    map('n', '<Leader>f',     ':Files<Space>.<CR>', 	    n)
    map('n', '<Leader>r',     ':Rg<Space>', 		        n)

    -- completion
    map('i', '<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],	    ne)
    map('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]],	    ne)

    -- lspsaga
    map('n', '<Leader>d', ':LspSagaDefPreview<CR>',	    ns)
    map('n', '<Leader>g', ':LspSagaFinder<CR>',	    ns)
    map('n', '<Leader>a', ':LspSagaCodeAction<CR>',	    ns)
    map('n', '<Leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>',	    ns)
    map('n', '<Leader>s', '<cmd>lua require(\'lspsaga.signaturehelp\').signature_help()<CR>',	    ns)
    map('n', '<Leader>n', ':LspSagaRename<CR>',	    ns)
    map('n', '[e',        ':LspSagaDiagJumpPrev<CR>',   ns)
    map('n', ']e',        ':LspSagaDiagJumpNext<CR>',   ns)
end

return keys
