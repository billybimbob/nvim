---@type vim.lsp.Config
return {
    settings = {
        format = true
    },
    on_init = function(client)
        client.server_capabilities.documentFormattingProvider = true
    end
}