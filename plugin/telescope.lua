vim.pack.add({
    'https://github.com/nvim-lua/plenary.nvim',
    -- 'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-telescope/telescope-ui-select.nvim',
    { name = 'telescope', src = 'https://github.com/nvim-telescope/telescope.nvim' },
})

-- other deps required for telescope (w/ windows):
-- c (using winlibs) for make, also freaking windows
-- winget install sharkdp.fd
-- winget install BurntSushi.ripgrep.MSVC

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        if ev.data.spec.name ~= 'telescope-fzf-native.nvim' then
            return
        end

        local kind = ev.data.kind
        if kind ~= 'install' and kind ~= 'update' then
            return
        end

        local make_cmd = nil
        if vim.fn.executable('make') == 1 then
            make_cmd = 'make'
        elseif vim.fn.executable('mingw32-make') == 1 then
            make_cmd = 'mingw32-make'
        end

        if make_cmd then
            vim.system({ make_cmd }, { cwd = ev.data.path }):wait()
        end
    end
})

vim.pack.add({
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim'
})

local telescope = require('telescope')

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
pcall(telescope.load_extension, 'fzf')
