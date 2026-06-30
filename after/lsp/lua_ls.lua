
local vim_runtime_path = vim.api.nvim_get_runtime_file('', true)

--@type vim.lsp.Config
return {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            },
            workspace = {
                library = vim_runtime_path,
                checkThirdParty = false
            }
        }
    }
}
