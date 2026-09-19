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
    'javascript',
    'jsdoc',
    'json',
    'yaml',
    'markdown',
    'markdown_inline',
    'diff',
    'sql',
    'editorconfig',
    'regex',
}

---@param cmd string
---@param langs table<string>
---@return boolean
local function add_lang(cmd, langs)
    if vim.fn.executable(cmd) == 0 then
        return false
    end
    vim.list_extend(extra_langs, langs)
    return true
end

add_lang('git', {
    'git_config',
    'git_rebase',
    'gitattributes',
    -- 'gitcommit',
    'gitignore',
})

add_lang('node', {
    'scss',
    'typescript',
    'tsx',
    'vue',
})

add_lang('go', {
    'go',
    'gomod',
    'gosum',
    'gotmpl',
    'gowork',
})

add_lang('bash', { 'bash' })
add_lang('docker', { 'dockerfile' })
add_lang('dotnet', { 'c_sharp' })
add_lang('pwsh', { 'powershell' })

if not add_lang('python3', { 'python' }) then
    add_lang('python', { 'python' })
end

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