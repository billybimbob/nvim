vim.pack.add({
    { name = 'mason',           src = 'https://github.com/mason-org/mason.nvim' },
    { name = 'mason-lspconfig', src = 'https://github.com/mason-org/mason-lspconfig.nvim' }
})

local servers = {
    'lua_ls',
    'postgres_lsp'
}

---@param cmd string
---@param lsps table<string>
---@return boolean
local function add_server(cmd, lsps)
    if vim.fn.executable(cmd) == 0 then
        return false
    end
    vim.list_extend(servers, lsps)
    return true
end

add_server('dotnet', { 'roslyn_ls' })
add_server('pwsh', { 'powershell_es' })

if not add_server('python3', { 'pyright' }) then
    add_server('python', { 'pyright' })
end

add_server('go', { 'gopls' })
add_server('node', {
    'html',
    'cssls',
    'jsonls',
    'ts_ls',
    'vue_ls',
    'eslint',
})

require('mason').setup()
require('mason-lspconfig').setup({
    automatic_enable = true,
    ensure_installed = servers,
})