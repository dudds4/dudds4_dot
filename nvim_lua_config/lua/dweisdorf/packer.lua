local ensure_packer = function()
  local fn = vim.fn
  local install_path = '/home/dweisdorf/repos/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost ~/.config/nvim/lua/dweisdorf/packer.lua source <afile> | PackerSync
  augroup end
]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use { 
        'nvim-telescope/telescope.nvim', tag = '0.1.0', 
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

	-- color scheme(s)
	-- use 'gruvbox-community/gruvbox'
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })

    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    -- use('nvim-treesitter/playground')

    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            -- Snippet Collection (Optional)
            {'rafamadriz/friendly-snippets'},
        }
    }

    -- Does auto close tags when typing HTML
    -- use 'alvan/vim-closetag'

    -- allows me to start nvim in the browser to edit text.
    -- use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

	-- selecting line in github.
	-- use 'ruanyl/vim-gh-line'

	-- use 'ggandor/leap.nvim'

end)
