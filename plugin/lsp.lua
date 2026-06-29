vim.pack.add{
    'https://github.com/neovim/nvim-lspconfig'
}

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false
            }
        }
    }
})

local vue_language_server_path = vim.fn.expand('$MASON\\packages\\vue-language-server\\node_modules\\@vue\\language-server')

local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = vue_language_server_path,
    languages = { 'vue' },
    configNamespace = 'typescript'
}

vim.lsp.config('ts_ls', {
    init_options = {
        plugins = {
            vue_plugin,
        }
    },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})

vim.lsp.enable({
    'html', -- html-lsp
    'cssls', -- css-lsp
    'jsonls', -- json-lsp
    'ts_ls',  -- typescript language server
    'eslint', -- eslint-lsp
})

-- vim.lsp.enable('vue_ls') -- vue-language-server

vim.lsp.enable('lua_ls') -- lua-language-server
-- vim.lsp.enable('pyright')
-- vim.lsp.enable('gopls')
vim.lsp.enable('postgres_lsp') -- postgres-language-server

vim.lsp.enable({
    'roslyn_ls', -- roslyn-language-server
    'powershell_es', -- powershell-editor-services
})

vim.opt.completeopt = { "menuone", "noselect", "popup" }

local extra_triggers = {}
for i = 32, 126 do
    local s = string.char(i)
    if s:match('[_%a]$') then
        table.insert(extra_triggers, s)
    end
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('custom.lsp', {}),
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

        if client:supports_method('textDocument/completion') then
            local triggers = assert(client.server_capabilities.completionProvider.triggerCharacters)
            vim.list_extend(triggers, extra_triggers)

            vim.lsp.completion.enable(true, client.id, ev.buf, {
                autotrigger = true,
                convert = function(item)
                    return { abbr = item.label:gsub('%b()', '') }
                end
            })
        end
    end
})
