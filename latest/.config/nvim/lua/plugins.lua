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

	-- Does auto close tags when typing HTML
	use 'alvan/vim-closetag'

	-- Make it so that when you yank something, the yanked text is 
	-- briefly highlighted.
	-- use 'machakann/vim-highlightedyank'

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

	-- Disabling coc while I try to set up a native lsp
	-- use 'neoclide/coc.nvim', {'branch': 'release'}

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

	-- selecting line in github.
	use 'ruanyl/vim-gh-line'

	-- AI powered auto completion, often super powerful
	-- Turning it off while I try to install native LSP
	-- auto complete using github copilot.
	-- use 'github/copilot.vim'
	
end)
