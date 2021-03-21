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
    -- packer itself
    use {'wbthomason/packer.nvim', opt = true}

    -- autoclose brackets, quotes, etc.
    use 'tmsvg/pear-tree'

    -- golang
    use 'fatih/vim-go'

    -- fzf (binaries and plugin)
    use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
    use 'junegunn/fzf.vim'

    -- status line
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'

    -- treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- lsp
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-compe'
    --use 'hrsh7th/vim-vsnip'
    --use 'hrsh7th/vim-vsnip-integ'
end)
