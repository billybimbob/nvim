local vue_language_server_path = vim.fn.expand('$MASON/packages' ..
    '/vue-language-server' .. '/node_modules/@vue/language-server')

local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = vue_language_server_path,
    languages = { 'vue' },
    configNamespace = 'typescript'
}

---@param client vim.lsp.Client
---@return boolean
local function eslint_claims_buffer(client)
    if not vim.lsp.is_enabled('eslint') then
        return false
    end

    local bufnr = next(client.attached_buffers)
    if not bufnr then
        return false
    end

    local eslint = vim.lsp.config.eslint
    if not eslint or type(eslint.root_dir) ~= 'function' then
        return false
    end

    local claimed = false
    eslint.root_dir(bufnr, function()
        claimed = true
    end)

    return claimed
end

---@type vim.lsp.Config
return {
    init_options = {
        plugins = {
            vue_plugin,
        }
    },
    on_init = function(client)
        if eslint_claims_buffer(client) then
            client.server_capabilities.documentFormattingProvider = nil
            client.server_capabilities.documentRangeFormattingProvider = nil
        end
    end,
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
}