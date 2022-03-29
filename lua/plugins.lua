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
    use 'b3nj5m1n/kommentary'

    -- search tools
    use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- status line
    use 'nvim-lualine/lualine.nvim'

    -- lisp repl integration
    use 'Olical/conjure'

    -- syntax highlighting
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- language server
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-compe'
    --use 'hrsh7th/vim-vsnip'
    --use 'hrsh7th/vim-vsnip-integ'
end)
