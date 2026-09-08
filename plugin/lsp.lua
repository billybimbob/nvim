vim.pack.add {
    'https://github.com/neovim/nvim-lspconfig'
}

vim.lsp.enable({
    'lua_ls',        -- lua-language-server
    'postgres_lsp',  -- postgres-language-server

    'html',          -- html-lsp
    'cssls',         -- css-lsp
    'jsonls',        -- json-lsp
    'ts_ls',         -- typescript language server

    'eslint',        -- eslint-lsp
    'vue_ls',        -- vue-language-server

    'roslyn_ls',     -- roslyn-language-server
    'powershell_es', -- powershell-editor-services
    'pyright',
    'gopls',
})

---@param ev vim.api.keyset.create_autocmd.callback_args
local function attach_lsp_modifiers(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

    if client:supports_method('textDocument/completion', ev.buf) then
        local all_triggers = {}
        for i = 32, 126 do
            table.insert(all_triggers, string.char(i))
        end

        client.server_capabilities.completionProvider.triggerCharacters = all_triggers

        vim.lsp.completion.enable(true, client.id, ev.buf, {
            autotrigger = true,
            convert = function(item)
                return { abbr = item.label:gsub('%b()', '') }
            end
        })
    end

    if client:supports_method('textDocument/documentHighlight', ev.buf) then
        local lsp_highlight = vim.api.nvim_create_augroup('lsp-highlighting', { clear = false })

        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = lsp_highlight,
            buf = ev.buf,
            callback = vim.lsp.buf.document_highlight
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            group = lsp_highlight,
            buf = ev.buf,
            callback = vim.lsp.buf.clear_references
        })
    end

    if client:supports_method('textDocument/formatting') and not client:supports_method('textDocument/willSaveWaitUntil') then
        local eslint_format = vim.api.nvim_create_augroup('eslint-on-save', { clear = false })

        local eslint_formatters = vim.api.nvim_get_autocmds({
            event = 'BufWritePre',
            group = eslint_format,
            buf = ev.buf
        })

        if #eslint_formatters == 0 then
            local lsp_format = vim.api.nvim_create_augroup('lsp-format-on-save', { clear = false })

            vim.api.nvim_create_autocmd('BufWritePre', {
                group = lsp_format,
                buf = ev.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
                end
            })
        end
    end

    if client.name == 'eslint' then
        local eslint_format = vim.api.nvim_create_augroup('eslint-on-save', { clear = false })
        local lsp_format = vim.api.nvim_create_augroup('lsp-format-on-save', { clear = false })

        vim.api.nvim_create_autocmd('BufWritePre', {
            group = eslint_format,
            buf = ev.buf,
            command = 'LspEslintFixAll'
        })

        vim.api.nvim_clear_autocmds({
            event = 'BufWritePre',
            group = lsp_format,
            buf = ev.buf
        })
    end
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = attach_lsp_modifiers
})

vim.api.nvim_create_autocmd('LspDetach', {
    callback = function(ev)
        local highlight_group = vim.api.nvim_create_augroup('lsp-highlighting', { clear = false })
        vim.api.nvim_clear_autocmds({ group = highlight_group, buf = ev.buf })
        vim.lsp.buf.clear_references()
    end
})