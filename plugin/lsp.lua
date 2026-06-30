vim.pack.add {
    'https://github.com/neovim/nvim-lspconfig'
}

vim.lsp.enable({
    'lua_ls',       -- lua-language-server
    'postgres_lsp', -- postgres-language-server

    'html',         -- html-lsp
    'cssls',        -- css-lsp
    'jsonls',       -- json-lsp
    'ts_ls',        -- typescript language server

    'eslint',       -- eslint-lsp
    -- 'vue_ls', -- vue-language-server

    'roslyn_ls',     -- roslyn-language-server
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

---@param ev vim.api.keyset.create_autocmd.callback_args
local function attach_lsp_modifiers(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

    if client:supports_method('textDocument/completion', ev.buf) then
        vim.list_extend(client.server_capabilities.completionProvider.triggerCharacters, extra_triggers)

        vim.lsp.completion.enable(true, client.id, ev.buf, {
            autotrigger = true,
            convert = function(item)
                return { abbr = item.label:gsub('%b()', '') }
            end
        })
    end

    if client:supports_method('textDocument/documentHighlight', ev.buf) then
        local highlight_group = vim.api.nvim_create_augroup('lsp-highlighting', { clear = false })

        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = ev.buf,
            group = highlight_group,
            callback = vim.lsp.buf.document_highlight
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = ev.buf,
            group = highlight_group,
            callback = vim.lsp.buf.clear_references
        })

        vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach-cleanup', { clear = true }),
            callback = function(ev2)
                vim.api.nvim_clear_autocmds({ group = highlight_group, buf = ev2.buf })
                vim.lsp.buf.clear_references()
            end
        })
    end

    if client:supports_method('textDocument/formatting') and not client:supports_method('textDocument/willSaveWaitUntil') then
        vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = ev.buf,
            callback = function()
                vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
            end
        })
    end
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = attach_lsp_modifiers
})
