-- some packages need install hooks, which is done via the PackChanged
-- event, but there is some timing issues where the hook doesn't trigger
-- when installing from a lock file
-- the workaround is to add all the install hooks in a single spot that
-- is called from init.lua

---@return string?
local function resolve_make()
    if vim.fn.executable('make') == 1 then
        return 'make'
    end
    if vim.fn.executable('mingw32-make') == 1 then
        return 'mingw32-make'
    end
end

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind

        if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
            local make_cmd = resolve_make()
            if make_cmd then
                vim.system({ make_cmd }, { cwd = ev.data.path }):wait()
            end
            return
        end

        if name == 'nvim-treesitter' and kind == 'update' then
            if not ev.data.active then
                vim.cmd('packadd nvim-treesitter')
            end
            vim.cmd('TSUpdate')
        end
    end
})