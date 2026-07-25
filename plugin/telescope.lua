-- other deps required for telescope (w/ windows):
-- c (using winlibs) for make, also freaking windows
-- winget install sharkdp.fd
-- winget install BurntSushi.ripgrep.MSVC

vim.pack.add({
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-telescope/telescope-ui-select.nvim',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
    { name = 'telescope', src = 'https://github.com/nvim-telescope/telescope.nvim' },
})

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup({
    defaults = {
        path_display = { 'filename_first', 'truncate' },
        dynamic_preview_title = true,
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
                ['<C-f>'] = false,

                ['<C-k>'] = 'preview_scrolling_up',
                ['<C-j>'] = 'preview_scrolling_down',
                ['<C-h>'] = 'preview_scrolling_left',
                ['<C-l>'] = 'preview_scrolling_right',

                ['<esc>'] = actions.close,
            }
        }
    },
    pickers = {
        buffers = {
            mappings = {
                i = {
                    ['<C-d>'] = actions.delete_buffer + actions.move_to_top
                }
            }
        }
    },
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown()
        }
    }
})

telescope.load_extension('ui-select')
telescope.load_extension('fzf')