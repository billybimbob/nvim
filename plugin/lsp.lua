vim.pack.add{
	'https://github.com/neovim/nvim-lspconfig'
}

vim.lsp.enable('lua_ls')
vim.lsp.enable('roslyn_ls')

vim.lsp.enable('html')
vim.lsp.enable('cssls')
vim.lsp.enable('jsonls')
vim.lsp.enable('ts_ls')

vim.lsp.enable('vue_ls')
vim.lsp.enable('eslint')

-- vim.lsp.enable('gopls')
vim.lsp.enable('postgres_lsp')
vim.lsp.enable('powershell_es')
vim.lsp.enable('pyright')
