local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
    -- lazy itself
    'folke/lazy.nvim',

    -- autoclose brackets, quotes, etc.
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },

    -- s-exp tools
    {
        'intarga/embrace.nvim',
        ft = {'scheme', 'racket'},
        dev = true
    },
    -- 'guns/vim-sexp',

    -- comment management
    {
        'b3nj5m1n/kommentary',
        config = function()
            require('kommentary.config').configure_language('default', {
                prefer_single_line_comments = true,
            })
        end
    },


    -- search tools
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
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
                        case_mode = 'smart_case',
                    }
                }
            }
            telescope.load_extension('fzf')
        end
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

    -- status line
    {
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
    },

    -- lisp repl integration
    {
        'Olical/conjure',
        config = function()
            vim.g['conjure#log#hud#anchor'] = "SE"
            vim.g['conjure#log#hud#border'] = "none"
            vim.g['conjure#eval#inline#prefix'] = "-> "
            vim.g['conjure#log#hud#width'] = 1.0
            vim.g['conjure#log#hud#enabled'] = true
            vim.g['conjure#mapping#eval_current_form'] = "f"
            vim.g['conjure#mapping#eval_comment_current_form'] = "c"
        end,
        ft = {'scheme', 'racket'}
    },

    {
        'benknoble/vim-racket',
        ft = 'racket'
    },

    -- syntax highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = { "c", "lua", "rust", "go", "css", "python", "javascript", "markdown", "haskell" },
                highlight = { enable = true },
                -- indent = { enable = true },
            }
        end
    },

    -- language server
    {
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
    },

    -- autocompletion
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    {
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require'cmp'

            cmp.setup({
                -- snippet = {
                --     -- REQUIRED - you must specify a snippet engine
                --     expand = function(args)
                --         vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                --         -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                --         -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                --         -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                --     end,
                -- },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ['<Tab>'] = function(fallback)
                        if not cmp.select_next_item() then
                            if vim.bo.buftype ~= 'prompt' and has_words_before() then
                                cmp.complete()
                            else
                                fallback()
                            end
                        end
                    end,

                    ['<S-Tab>'] = function(fallback)
                        if not cmp.select_prev_item() then
                            if vim.bo.buftype ~= 'prompt' and has_words_before() then
                                cmp.complete()
                            else
                                fallback()
                            end
                        end
                    end,
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    -- { name = 'vsnip' }, -- For vsnip users.
                    -- { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                }, {
                    { name = 'buffer' },
                })
            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
                }, {
                    { name = 'buffer' },
                })
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })

            -- Set up lspconfig.
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
            -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
            --     capabilities = capabilities
            -- }
        end
    },
},
{
    dev = {
        path = "~/etc",
        fallback = true,
    }
})
