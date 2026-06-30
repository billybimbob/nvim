local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>pd', builtin.diagnostics, { desc = 'Diagnostics' })
vim.keymap.set('n', '<leader>pg', builtin.live_grep, { desc = 'Live grep' })

vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input('Grep > ') })
end)

vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'git files' })
vim.keymap.set('n', '<C-i><C-l>', builtin.git_commits, { desc = 'git commits' })
vim.keymap.set('n', '<C-i><C-h>', builtin.git_stash, { desc = 'git stash' })
vim.keymap.set('n', '<C-i><C-p>', builtin.git_branches, { desc = 'git branches' })

---@param event vim.api.keyset.create_autocmd.callback_args
local function attach_lsp_telescope(event)
    vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = event.buf, desc = 'Open Document Symbols' })
    vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = event.buf, desc = '[G]oto [R]eferences' })

    vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = event.buf, desc = '[G]oto [I]mplementation' })
    vim.keymap.set('n', 'gi', builtin.lsp_implementations, { buffer = event.buf })

    vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = event.buf, desc = '[G]oto [D]efinition' })
    vim.keymap.set('n', 'gd', builtin.lsp_definitions, { buffer = event.buf })

    vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = event.buf, desc = '[G]oto [T]ype Definition' })
    vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, { buffer = event.buf })
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = attach_lsp_telescope
})
