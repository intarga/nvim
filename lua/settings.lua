local cmd, o, b, w = vim.api.nvim_command, vim.o, vim.bo, vim.wo
local settings = {}

function settings.setup()
    -- tabs vs spaces
    local indent = 4
    b.expandtab = true
    o.expandtab = true -- might become unnecessary?
    b.shiftwidth = indent
    o.shiftwidth = indent
    b.tabstop = indent
    o.tabstop = indent

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
    w.cursorline = true
    w.cursorlineopt = "number"

    -- enable autocompletion
    o.completeopt = 'menu,menuone,noselect'

    -- colours!
    -- redo when api is fixed...
    cmd('colorscheme alnj')

    -- lsp diagnostic signs
    cmd('sign define LspDiagnosticsSignError text=> texthl=LspDiagnosticsSignError linehl= numhl=')
    cmd('sign define LspDiagnosticsSignWarning text=! texthl=LspDiagnosticsSignWarning linehl= numhl=')
    cmd('sign define LspDiagnosticsSignInformation text=i texthl=LspDiagnosticsSignInformation linehl= numhl=')
    cmd('sign define LspDiagnosticsSignHint text=H texthl=LspDiagnosticsSignHint linehl= numhl=')

    -- Resume where we left off when opening a file
    cmd([[autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]])

    -- Remove trailing whitespace on write
    cmd([[autocmd BufWritePre * %s/\s\+$//e]])

    -- Disable automatic commenting on newline
    --cmd([[autocmd FileType * setlocal formatoptions-=cro]])
    cmd([[autocmd BufNewFile,BufRead,FileType,OptionSet * set formatoptions-=cro]])
    cmd([[autocmd BufNewFile,BufRead,FileType,OptionSet * setlocal formatoptions-=cro]])

    -- Autoformat on write
    cmd([[autocmd BufWrite *.rs,*.go,*.lua,*.py,*.sh :lua vim.lsp.buf.formatting_sync()]])

    -- disable matchparen in insert mode
    cmd([[autocmd InsertEnter * NoMatchParen]])
    cmd([[autocmd InsertLeave * DoMatchParen]])

    -- conjure
    vim.g['conjure#log#hud#anchor'] = "SE"
    vim.g['conjure#log#hud#border'] = "none"
    vim.g['conjure#eval#inline#prefix'] = "-> "
    vim.g['conjure#log#hud#width'] = 1.0
    vim.g['conjure#log#hud#enabled'] = false
    vim.g['conjure#mapping#eval_current_form'] = "f"
    vim.g['conjure#mapping#eval_comment_current_form'] = "c"

    -- Kommentary
    --vim.g.kommentary_create_default_mappings = false
    --require('kommentary.config').use_extended_mappings()
    require('kommentary.config').configure_language("default", {
        prefer_single_line_comments = true,
    })

    -- telescope
    local telescope = require('telescope')
    telescope.setup {
        defaults = require('telescope.themes').get_dropdown {
            mappings = {
                i = {
                    ["<C-B>"] = "select_default",
                }
            }
        },
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            }
        }
    }
    telescope.load_extension('fzf')

    -- status line
    local my16color = {
        normal = {
            a = { fg = 0, bg = 12, gui = 'bold' },
            b = { fg = 0, bg = 4 },
            c = { fg = NONE, bg = 0 },
        },
        insert = {
            a = { fg = 0, bg = 13, gui = 'bold' },
            b = { fg = 0, bg = 5 },
        },
        visual = {
            a = { fg = 0, bg = 10, gui = 'bold' },
            b = { fg = 0, bg = 2 },
        },
        replace = {
            a = { fg = 0, bg = 11, gui = 'bold' },
            b = { fg = 0, bg = 3 },
        },
    }

    require'lualine'.setup {
        options = {
            theme = my16color,
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            always_divide_middle = true,
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch'},
            lualine_c = {{'buffers', buffers_color = {
                active = {fg = NONE},
                inactive = {fg = 12},
            }}},
            lualine_x = {
                {'diff', diff_color = {
                    added = {fg = 2},
                    modified = {fg = 3},
                    removed = {fg = 5},
                }},
                {'diagnostics', icons_enabled = false, diagnostics_color = {
                    error = {fg = 0, bg = 9},
                    warn = {fg = 1},
                    info = {fg = 3},
                    hint = {fg = 4},
                }},
            },
            lualine_y = {
                'encoding',
                {'filetype', color = {gui = 'bold'}},
                {'fileformat', icons_enabled = false},
            },
            lualine_z = {'progress', 'location'}
        },
    }

    -- Treesitter
    require'nvim-treesitter.configs'.setup {
        --checks parser is maintained
        ensure_installed = "maintained",
        highlight = { enable = true },
        -- indent = { enable = true },
    }

    -- LSP
    local lspconfig = require'lspconfig'
    lspconfig.gopls.setup{}
    lspconfig.rust_analyzer.setup{}
    lspconfig.pyright.setup{}
    lspconfig.efm.setup {
        init_options = {documentFormatting = true},
        filetypes = { 'lua','sh','python' },
        settings = {
            rootMarkers = {".git/"},
            languages = {
                lua = {
                    {formatCommand = "lua-format -i", formatStdin = true}
                },
                sh = {
                    {
                        lintCommand = "shellcheck -f gcc -x",
                        lintSource = "shellcheck",
                        lintFormats = {
                            "%f:%l:%c: %trror: %m",
                            "%f:%l:%c: %tarning: %m",
                            "%f:%l:%c: %tote: %m"
                        }
                    },
                    {formatCommand = "shfmt -ci -s -bn", formatStdin = true}
                },
                python = {
                    {formatCommand = "black --quiet -", formatStdin = true}
                }
            }
        }
    }

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
