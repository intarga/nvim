local cmd, o, b, w = vim.api.nvim_command, vim.o, vim.bo, vim.wo
local settings = {}

function settings.setup()
    -- tabs vs spaces
    local indent = 4
    b.expandtab = true
    o.expandtab = true -- might become unnecessary?
    b.shiftwidth = indent
    b.tabstop = indent

    -- enable mouse in all modes
    o.mouse = 'a'

    -- use system clipboard - may require installing xclip
    o.clipboard = 'unnamedplus'

    -- open splits below and to the right
    o.splitbelow = true
    o.splitright = true

    -- line numbers
    w.number = true
    w.relativenumber = true

    -- enable autocompletion
    o.completeopt = 'menu,menuone,noselect'

    -- colours!
    -- redo when api is fixed...
    cmd('colorscheme brint')

    -- python
    cmd('let g:python3_host_prog="/usr/bin/python3"')

    -- lsp diagnostic signs
    cmd('sign define LspDiagnosticsSignError text=> texthl=LspDiagnosticsSignError linehl= numhl=')
    cmd('sign define LspDiagnosticsSignWarning text=! texthl=LspDiagnosticsSignWarning linehl= numhl=')
    cmd('sign define LspDiagnosticsSignInformation text=i texthl=LspDiagnosticsSignInformation linehl= numhl=')
    cmd('sign define LspDiagnosticsSignHint text=H texthl=LspDiagnosticsSignHint linehl= numhl=')

    -- airline
    cmd('let g:airline_powerline_fonts = 1')
    cmd('let g:airline_skip_empty_sections = 1')
    cmd('let g:airline_theme=\'monochrome\'')
    --cmd('let g:airline_solarized_bg=\'dark\'')

    -- Remove trailing whitespace on write
    cmd([[autocmd BufWritePre * %s/\s\+$//e]])

    -- Disable automatic commenting on newline
    cmd([[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]])

    -- Autoformat on write
    cmd([[au BufWrite * :Autoformat]])

    -- Treesitter
    require'nvim-treesitter.configs'.setup {
        --checks parser is maintained
        ensure_installed = "maintained",
        highlight = { enable = true },
    }

    -- LSP
    local lspconfig = require'lspconfig'
    lspconfig.gopls.setup{}
    lspconfig.rust_analyzer.setup({})

    require'compe'.setup {
        enabled = true;
        autocomplete = true;
        debug = false;
        min_length = 1;
        preselect = 'disable';
        throttle_time = 80;
        source_timeout = 200;
        incomplete_delay = 400;
        allow_prefix_unmatch = false;

        source = {
            path = true;
            buffer = true;
            vsnip = true;
            nvim_lsp = true;
            nvim_lua = true;
            your_awesome_source = {};
        };
    }
end

return settings
