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

vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)

    --- TODO:
    -- consider vim-surround
    -- consider a comment plugin


    -------- following guide for LSP / auto completions


    -- auto complete
	use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
	use 'hrsh7th/cmp-buffer' -- this might not be good.
	use 'hrsh7th/cmp-path'

    -- snippets
	use 'L3MON4D3/LuaSnip' -- Snippets plugin
	use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'rafamadriz/friendly-snippets' -- Snippets

    -- lsp server manager
    use { 'williamboman/mason.nvim' }
    use { 'williamboman/mason-lspconfig.nvim' }
    use "neovim/nvim-lspconfig"

    --- Configuring lsp servers ---

    -- Use LSP servers as a source for autocompletion
	use 'hrsh7th/cmp-nvim-lsp'
	use { 'glepnir/lspsaga.nvim', branch = "main" }
	use 'onsails/lspkind.nvim'


	-- use {'neoclide/coc.nvim', branch= 'release'}

	-- disabling LSP, need to do work, and COC works.
	-- -- Configurations for Nvim LSP
	-- use 'neovim/nvim-lspconfig'


	-- Does auto close tags when typing HTML
	use 'alvan/vim-closetag'

	-- allows me to start nvim in the browser to edit text.
	use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

	--fuzzy search
	use { 'junegunn/fzf', run = function() vim.fun['fzf#install'](0) end }
	use 'junegunn/fzf.vim'

	-- harpoon + fuzzy finder
	use { 'nvim-treesitter/nvim-treesitter', run = function() vim.fun[':TSUpdate'](0) end }

	use 'nvim-lua/plenary.nvim'  -- dependency
	use 'ThePrimeagen/harpoon'
	use 'nvim-telescope/telescope.nvim'

	-- show current context line at top.
	use 'nvim-treesitter/nvim-treesitter-context'

	-- keeps an undo tree, pretty neat.
	use 'mbbill/undotree'


	-- I wanted to try this plugin, but it requires the prerelease version of nvim
	-- As of Dec 2022, I don't really use this for jumping anymore
	-- use 'tpope/vim-repeat'
	-- use 'ggandor/lightspeed.nvim'
	-- use 'ggandor/leap.nvim'

	--git blames, diffs, logs, and such
	use 'tpope/vim-fugitive'

	--man pages
	use 'vim-utils/vim-man'

	-- color scheme(s)
	use 'gruvbox-community/gruvbox'
	use { 'catppuccin/nvim', as = 'catppuccin' }
    use 'sam4llis/nvim-tundra'

	-- selecting line in github.
	use 'ruanyl/vim-gh-line'

	-- AI powered auto completion, often super powerful
	-- Turning it off while I try to install native LSP
	-- auto complete using github copilot.
	-- use 'github/copilot.vim'

	-- hook up copilot to lua lsp
	-- use "zbirenbaum/copilot.lua"
	-- use "zbirenbaum/copilot-cmp"

	use {
	    "zbirenbaum/copilot.lua",
	    -- event = "VimEnter",
	    -- config = function()
	    --     --vim.defer_fn(function()
	    --         require("copilot").setup({
	    --             suggestion = {
	    --                 enabled = false,
	    --                 -- auto_trigger = true,
	    --                 -- debouce = 100,
        --                 -- keymap = {
        --                 --     -- accept using tab
        --                 --     accept = "<C-y>",
        --                 --     next = "<C-n>",
        --                 --     prev = "<C-p>",
        --                 -- }
	    --             },
	    --         })
	    --     --end, 100)
	    -- end,
	}

	use {
	    "zbirenbaum/copilot-cmp",
	    after = { "copilot.lua" },
	    config = function ()
	        require("copilot_cmp").setup({
	            method="getCompletionsCycling",
	        })
	    end
	}

end)
