vim.pack.add{
	'https://github.com/neovim/nvim-lspconfig'
}

vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			}
		}
	}
})

local vue_language_server_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'

local vue_plugin = {
	name = '@vue/typescript-plugin',
	location = vue_language_server_path,
	languages = { 'vue' },
	configNamespace = 'typescript'
}

vim.lsp.config('vtsls', {
	filetypes = { 'typescript', 'javascript', 'javscriptreact', 'typescriptreact', 'vue' },
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					vue_plugin
				}
			}
		}
	}
})

vim.lsp.enable('lua_ls')
vim.lsp.enable('roslyn_ls')

vim.lsp.enable('html')
vim.lsp.enable('cssls')

vim.lsp.enable('jsonls')
vim.lsp.enable('vtsls')
vim.lsp.enable('vue_ls')
vim.lsp.enable('eslint')

-- vim.lsp.enable('gopls')
vim.lsp.enable('postgres_lsp')
vim.lsp.enable('powershell_es')
vim.lsp.enable('pyright')
