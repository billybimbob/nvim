vim.pack.add({
	{ name = 'rose-pine', src = 'https://github.com/rose-pine/neovim' }
})

require('rose-pine').setup()

vim.cmd.colorscheme('rose-pine')
