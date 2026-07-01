---@type vim.lsp.Config
return {
    on_init = function(client)
        if not client.workspace_folders then
            return
        end

        local path = client.workspace_folders[1].name
        local is_config = path == vim.fn.stdpath('config')
        local has_rc = vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')

        if not is_config and has_rc then
            return
        end

        ---@type lspconfig.settings.lua_ls
        local config_settings = client.config.settings

        ---@type lspconfig.settings.lua_ls
        local neovim_settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = {
                        'lua/?.lua',
                        'lua/?/init.lua',
                    },
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                        vim.api.nvim_get_runtime_file('lua/lspconfig', false)[1],
                    },
                }
            }
        }

        config_settings.Lua = vim.tbl_deep_extend('force', config_settings.Lua, neovim_settings.Lua)
    end,
    settings = {
        Lua = {}
    },
}
