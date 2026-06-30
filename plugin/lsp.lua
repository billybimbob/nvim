vim.pack.add{
    'https://github.com/neovim/nvim-lspconfig'
}

vim.lsp.enable({
    'lua_ls', -- lua-language-server
    'postgres_lsp', -- postgres-language-server

    'html', -- html-lsp
    'cssls', -- css-lsp
    'jsonls', -- json-lsp
    'ts_ls',  -- typescript language server

    'eslint', -- eslint-lsp
    -- 'vue_ls', -- vue-language-server

    'roslyn_ls', -- roslyn-language-server
    'powershell_es', -- powershell-editor-services
    -- 'pyright',
    -- 'gopls',
})

vim.opt.completeopt = { "menuone", "noselect", "popup" }

local extra_triggers = {}
for i = 32, 126 do
    local s = string.char(i)
    if s:match('[_%a]$') then
        table.insert(extra_triggers, s)
    end
end

---@param event vim.api.keyset.create_autocmd.callback_args
local function enable_autocomplete(event)
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

    if client:supports_method('textDocument/completion') then
        vim.lsp.completion.enable(true, client.id, event.buf, {
            autotrigger = true,
            convert = function(item)
                return { abbr = item.label:gsub('%b()', '') }
            end
        })
        vim.list_extend(client.server_capabilities.completionProvider.triggerCharacters, extra_triggers)
    end
end

vim.api.nvim_create_autocmd('LspAttach', { callback = enable_autocomplete })
