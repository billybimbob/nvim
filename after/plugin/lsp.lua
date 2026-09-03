vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        vim.keymap.set('n', 'gh', vim.lsp.buf.hover, { buf = ev.buf })
        vim.keymap.set('n', '<leader>gh', vim.diagnostic.open_float, { buf = ev.buf })
        vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { buf = ev.buf })
        vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = ev.buf })
    end
})