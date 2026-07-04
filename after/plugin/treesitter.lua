local textobjects_select = require('nvim-treesitter-textobjects.select')

vim.keymap.set({ 'x', 'o' }, 'if', function()
    textobjects_select.select_textobject('@function.inner', 'textobjects')
end)

vim.keymap.set({ 'x', 'o' }, 'af', function()
    textobjects_select.select_textobject('@function.outer', 'textobjects')
end)

vim.keymap.set({ 'x', 'o' }, 'im', function()
    textobjects_select.select_textobject('@parameter.inner', 'textobjects')
end)

vim.keymap.set({ 'x', 'o' }, 'am', function()
    textobjects_select.select_textobject('@parameter.outer', 'textobjects')
end)