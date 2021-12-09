local api, g, o = vim.api, vim.g, vim.o

local skip_providers = function()
    --[[ g.python_host_skip_check = 1
    g.python_host_prog = '/usr/bin/python2' ]]
    g.loaded_python_provider = 0
    g.python3_host_skip_check = 1
    g.python3_host_prog = '/usr/local/bin/python3'
    g.loaded_node_provider = 0
    g.loaded_ruby_provider = 0
    g.loaded_perl_provider = 0
end

local disable_distribution_plugins = function()
    -- edit inside zips
    g.loaded_gzip              = 1
    g.loaded_tar               = 1
    g.loaded_tarPlugin         = 1
    g.loaded_zip               = 1
    g.loaded_zipPlugin         = 1

    -- update vimscripts. Seems redundant with plugin managers
    g.loaded_getscript         = 1
    g.loaded_getscriptPlugin   = 1

    -- vim's own archiving system???
    g.loaded_vimball           = 1
    g.loaded_vimballPlugin     = 1

    -- extends automatic parenthesis navigation (%) to also work with keywords
    g.loaded_matchit           = 1

    -- highlight parenthesis matching that under the cursor
    g.loaded_matchparen        = 1

    -- convert buffer to html?
    g.loaded_2html_plugin      = 1

    -- apply logic to regex searches (:LogiPat)
    g.loaded_logiPat           = 1

    -- utility to improve remote-vim experience?
    g.loaded_rrhelper          = 1

    -- builtin file explorer
    g.loaded_netrwPlugin       = 1
    g.loaded_netrwSettings     = 1
    g.loaded_netrwFileHandlers = 1
end

local setup = function()
    skip_providers()
    disable_distribution_plugins()

    require'plugins'
    require'keys'.setup()
    require'settings'.setup()
end

setup()


