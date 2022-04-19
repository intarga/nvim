local execute = vim.api.nvim_command
local fn = vim.fn

-- install packer automatically if we don't have it
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end

--because packer is in opt
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- packer plugin manager itself
    use {'wbthomason/packer.nvim', opt = true}

    -- autoclose brackets, quotes, etc.
    use 'tmsvg/pear-tree'

    -- s-exp tools
    use '~/etc/embrace'
    -- use 'guns/vim-sexp'

    -- comment management
    use {
        'b3nj5m1n/kommentary',
        config = function()
            require('kommentary.config').configure_language("default", {
                prefer_single_line_comments = true,
            })
        end
    }


    -- search tools
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} },
        config = function()
            local telescope = require('telescope')
            telescope.setup {
                defaults = require('telescope.themes').get_dropdown {
                    mappings = {
                        i = { ["<C-B>"] = "select_default" }
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
        end
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- status line
    use {
        'nvim-lualine/lualine.nvim',
        config = function()
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
        end
    }

    -- lisp repl integration
    use {
        'Olical/conjure',
        config = function()
            vim.g['conjure#log#hud#anchor'] = "SE"
            vim.g['conjure#log#hud#border'] = "none"
            vim.g['conjure#eval#inline#prefix'] = "-> "
            vim.g['conjure#log#hud#width'] = 1.0
            vim.g['conjure#log#hud#enabled'] = false
            vim.g['conjure#mapping#eval_current_form'] = "f"
            vim.g['conjure#mapping#eval_comment_current_form'] = "c"
        end,
        ft = 'scheme'
    }

    -- syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = "all",
                highlight = { enable = true },
                -- indent = { enable = true },
            }
        end
    }

    -- language server
    use {
        'neovim/nvim-lspconfig',
        config = function()
            -- LSP
            local lspconfig = require'lspconfig'
            lspconfig.gopls.setup{}
            lspconfig.rust_analyzer.setup{}
            lspconfig.pyright.setup{}
            lspconfig.efm.setup {
                init_options = {documentFormatting = true},
                filetypes = { 'lua','sh','python','css','html' },
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
                        },
                        css = {
                            {formatCommand = "prettier --parser css", formatStdin = true}
                        },
                        html = {
                            {formatCommand = "prettier --parser html", formatStdin = true}
                        },
                    }
                }
            }
        end
    }

    -- autocompletion
    use {
        'hrsh7th/nvim-compe',
        config = function()
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
    }
    --use 'hrsh7th/vim-vsnip'
    --use 'hrsh7th/vim-vsnip-integ'
end)
