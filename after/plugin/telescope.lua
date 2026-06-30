local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>pg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = 'Telescope buffers' })

vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input('Grep > ') })
end)

vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope git files' })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
      vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = ev.buf, desc = '[G]oto [R]eferences' })
      vim.keymap.set('n', 'gR', builtin.lsp_references, { buffer = ev.buf })

      vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = ev.buf, desc = '[G]oto [I]mplementation' })
      vim.keymap.set('n', 'gi', builtin.lsp_implementations, { buffer = ev.buf })

      vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = ev.buf, desc = '[G]oto [D]efinition' })
      vim.keymap.set('n', 'gd', builtin.lsp_definitions, { buffer = ev.buf })

      vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = ev.buf, desc = 'Open Document Symbols' })
      vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = ev.buf, desc = 'Open Workspace Symbols' })

      vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = ev.buf, desc = '[G]oto [T]ype Definition' })
      vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, { buffer = ev.buf })
    end
})

