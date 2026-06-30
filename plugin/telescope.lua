vim.pack.add({
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
    'https://github.com/nvim-telescope/telescope-ui-select.nvim',
    { name = 'telescope', src = 'https://github.com/nvim-telescope/telescope.nvim' },
})

-- other deps required for telescope (w/ windows):
-- winget install sharkdp.fd
-- winget install BurntSushi.ripgrep.MSVC

require('telescope').setup({
    extensions = {
        ['ui-select'] = { require('telescope.themes').get_dropdown() }
    }
})

require('telescope').load_extension('ui-select')
