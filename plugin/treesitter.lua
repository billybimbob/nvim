-- need to have a c complier to add the extra langs
-- getting c on windows was... tough
-- easiest way i have found was using a prebuilt version of winlibs:
-- https://winlibs.com/
-- 1. winget install BrechtSanders.WinLibs.POSIX.UCRT (this is on windows 11)
-- 2. add CC = gcc in the path

vim.pack.add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-context',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects'
})

local extra_langs = {
    'html',
    'css',
    'scss',
    'typescript',
    'tsx',
    'vue',
    'diff',
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

require('nvim-treesitter').install(extra_langs)

require('nvim-treesitter-textobjects').setup({
    selection = {
        lookahead = true,
        include_surrounding_whitespace = false
    },
    move = {
        set_jumps = true
    }
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = extra_langs,
    callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
})