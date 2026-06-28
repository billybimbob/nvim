vim.pack.add({
	'https://github.com/neovim-treesitter/treesitter-parser-registry',
	{ name = 'nvim-treesitter', src = 'https://github.com/neovim-treesitter/nvim-treesitter' },
	{ name = 'treesitter-context', src = 'https://github.com/nvim-treesitter/nvim-treesitter-context' }
})

local nvim_treesitter = require('nvim-treesitter')

local extra_langs = {
	'html',
	'css',
	'scss',
	'typescript',
	'tsx',
	'vue',
	'git_config',
	'git_rebase',
	'gitattributes',
	'gitcommit',
	'gitignore',
	'go',
	'gomod',
	'gosum',
	'gotmpl',
	'gowork',
	'json',
	'yaml',
	'sql',
	'c_sharp',
	'powershell',
	'python',
	'editorconfig'
}

-- need to have a c complier to add the extra langs
-- getting c on windows was... tough
-- easiest way i have found was using a prebuilt version of winlibs:
-- https://winlibs.com/
-- 1. winget install BrechtSanders.WinLibs.POSIX.UCRT (this is on windows 11)
-- 2. add CC = gcc in the path

nvim_treesitter.install(extra_langs)

vim.api.nvim_create_autocmd('FileType', {
	pattern = extra_langs,
	callback = function()
		vim.treesitter.start()
	   	vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
	    	vim.wo.foldmethod = 'expr'
	    	vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end
})
