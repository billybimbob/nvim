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

vim.lsp.config('vtsls', {
	filetypes = { 'typescript', 'javascript', 'javscriptreact', 'typescriptreact', 'vue' },
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					vue_plugin= {
						name = '@vue/typescript-plugin',
						location = vue_language_server_path,
						languages = { 'vue' },
						configNamespace = 'typescript'
					}
				}
			}
		}
	}
})

vim.lsp.enable('lua_ls') -- lua-language-server
vim.lsp.enable('roslyn_ls') -- roslyn-language-server

vim.lsp.enable('html') -- html-lsp
vim.lsp.enable('cssls') -- css-lsp

vim.lsp.enable('jsonls') -- json-lsp
vim.lsp.enable('vtsls') -- vtsls
vim.lsp.enable('vue_ls') -- vue-language-server
vim.lsp.enable('eslint') -- eslint-lsp

-- vim.lsp.enable('gopls')
vim.lsp.enable('postgres_lsp') -- postgres-language-server
vim.lsp.enable('powershell_es') -- powershell-editor-services
vim.lsp.enable('pyright') -- pyright
