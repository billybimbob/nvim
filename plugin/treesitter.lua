vim.pack.add({
    'https://github.com/neovim-treesitter/treesitter-parser-registry',
    { name = 'treesitter-context', src = 'https://github.com/nvim-treesitter/nvim-treesitter-context' },
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects'
})

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        if ev.data.spec.name ~= 'nvim.treesitter' then
            return
        end

        local kind = ev.data.kind
        if kind ~= 'install' and kind ~= 'update' then
            return
        end

        vim.cmd('TSUpdate')
    end
})

vim.pack.add({
    { name = 'nvim-treesitter', src = 'https://github.com/neovim-treesitter/nvim-treesitter' }
})

-- need to have a c complier to add the extra langs
-- getting c on windows was... tough
-- easiest way i have found was using a prebuilt version of winlibs:
-- https://winlibs.com/
-- 1. winget install BrechtSanders.WinLibs.POSIX.UCRT (this is on windows 11)
-- 2. add CC = gcc in the path

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

local nvim_treesitter = require('nvim-treesitter')
local nvim_treesitter_textobjects = require('nvim-treesitter-textobjects')

nvim_treesitter.install(extra_langs)
nvim_treesitter_textobjects.setup({
    lookahead = true
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = extra_langs,
    callback = function()
        vim.treesitter.start()
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
})

local function get_textobject_select()
    return require('nvim-treesitter-textobjects.select')
end

vim.keymap.set({ 'x', 'o' }, 'if', function()
    get_textobject_select().select_textobject('@function.inner', 'textobjects')
end)
vim.keymap.set({ 'x', 'o' }, 'af', function()
    get_textobject_select().select_textobject('@function.outer', 'textobjects')
end)

vim.keymap.set({ 'x', 'o' }, 'im', function()
    get_textobject_select().select_textobject('@parameter.inner', 'textobjects')
end)
vim.keymap.set({ 'x', 'o' }, 'am', function()
    get_textobject_select().select_textobject('@parameter.outer', 'textobjects')
end)
