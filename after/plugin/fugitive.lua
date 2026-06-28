vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
vim.keymap.set('n', '<leader>gss', function()
	vim.cmd.Git(vim.fn.input('Git Command > '))
end)
