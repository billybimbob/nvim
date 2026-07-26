-- selects
local ts_select = require('nvim-treesitter-textobjects.select')

vim.keymap.set({ 'x', 'o' }, 'im', function()
    ts_select.select_textobject('@function.inner', 'textobjects')
end)
vim.keymap.set({ 'x', 'o' }, 'am', function()
    ts_select.select_textobject('@function.outer', 'textobjects')
end)

vim.keymap.set({ 'x', 'o' }, 'ir', function()
    ts_select.select_textobject('@parameter.inner', 'textobjects')
end)
vim.keymap.set({ 'x', 'o' }, 'ar', function()
    ts_select.select_textobject('@parameter.outer', 'textobjects')
end)

vim.keymap.set({ 'x', 'o' }, 'if', function()
    ts_select.select_textobject('@conditional.inner', 'textobjects')
end)
vim.keymap.set({ 'x', 'o' }, 'af', function()
    ts_select.select_textobject('@conditional.outer', 'textobjects')
end)

-- moves
local ts_move = require('nvim-treesitter-textobjects.move')

vim.keymap.set({ "n", "x", "o" }, "]m", function()
    ts_move.goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[m", function()
    ts_move.goto_previous_start("@function.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "]M", function()
    ts_move.goto_next_end("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[M", function()
    ts_move.goto_previous_end("@function.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "]f", function()
    ts_move.goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[f", function()
    ts_move.goto_previous_start("@function.outer", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "]F", function()
    ts_move.goto_next_end("@conditional.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[F", function()
    ts_move.goto_previous_end("@conditional.outer", "textobjects")
end)

-- repeat moves
local ts_repeat_move = require('nvim-treesitter-textobjects.repeatable_move')

vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })