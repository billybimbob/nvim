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

local vue_language_server_path = vim.fn.expand('$MASON\\packages\\vue-language-server\\node_modules\\@vue\\language-server')

local vue_plugin = {
	name = '@vue/typescript-plugin',
	location = vue_language_server_path,
	languages = { 'vue' },
	configNamespace = 'typescript'
}

vim.lsp.config('ts_ls', {
	init_options = {
		plugins = {
			vue_plugin,
		}
	},
	filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})


vim.lsp.config('vue_ls', {})

vim.lsp.enable({
	'lua_ls', -- lua-language-server
	'roslyn_ls', -- roslyn-language-server

	'html', -- html-lsp
	'cssls', -- css-lsp

	'jsonls', -- json-lsp
	'ts_ls',  -- typescript language server
	'vue_ls', -- vue-language-server
	'eslint', -- eslint-lsp

	-- 'gopls',
	'postgres_lsp', -- postgres-language-server
	'powershell_es', -- powershell-editor-services
	'pyright', -- pyright
})
