local cmd, au, opt = vim.api.nvim_command, vim.api.nvim_create_autocmd, vim.opt
local settings = {}

function settings.setup()
    -- tabs vs spaces
    local indent = 4
    opt.expandtab = true
    opt.shiftwidth = indent
    opt.tabstop = indent

    -- enable mouse in all modes
    opt.mouse = 'a'

    -- use system clipboard - may require installing xclip
    opt.clipboard = 'unnamedplus'

    -- open splits below and to the right
    opt.splitbelow = true
    opt.splitright = true

    -- line numbers
    opt.number = true
    opt.relativenumber = true
    opt.cursorline = true
    opt.cursorlineopt = "number"

    -- enable autocompletion
    opt.completeopt = 'menu,menuone,noselect'

    -- colours!
    -- redo when api is fixed...
    cmd('colorscheme alnj')

    -- lsp diagnostic signs
    cmd('sign define LspDiagnosticsSignError text=> texthl=LspDiagnosticsSignError linehl= numhl=')
    cmd('sign define LspDiagnosticsSignWarning text=! texthl=LspDiagnosticsSignWarning linehl= numhl=')
    cmd('sign define LspDiagnosticsSignInformation text=i texthl=LspDiagnosticsSignInformation linehl= numhl=')
    cmd('sign define LspDiagnosticsSignHint text=H texthl=LspDiagnosticsSignHint linehl= numhl=')

    -- Resume where we left off when opening a file
    au("BufReadPost", {
        pattern = "*",
        command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]]
    })

    -- Remove trailing whitespace on write
    au("BufWritePre", { pattern = "*", command = [[%s/\s\+$//e]] })

    -- Disable automatic commenting on newline
    au({ "BufNewFile", "BufRead", "FileType", "OptionSet" }, {
        pattern = "*",
        command = "set formatoptions-=cro | setlocal formatoptions-=cro"
    })

    -- Autoformat on write
    au("BufWrite", {
        pattern = { "*.rs", "*.go", "*.lua", "*.py", "*.sh", "*.css", "*.html"},
        callback = vim.lsp.buf.format
    })

    -- disable matchparen in insert mode
    au("InsertEnter", { pattern = "*", command = "NoMatchParen" })
    au("InsertLeave", { pattern = "*", command = "DoMatchParen" })
end

return settings
