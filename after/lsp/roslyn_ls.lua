---@param file_name string
---@param ext string
---@return boolean
local function has_ext(file_name, ext)
    return vim.fs.ext(file_name) == ext
end

---@param bufnr integer
---@return string?
local function root_sln(bufnr)
    local root_dir = vim.fs.root(bufnr, { '.git/', 'src/' })
    if not root_dir then
        return
    end
    return vim.fs.root(root_dir, function(fname)
        return has_ext(fname, 'sln')
    end)
end

---@param bufnr integer
---@param on_dir fun(root_dir: string)
local function find_root_dir(bufnr, on_dir)
    local sln_dir = root_sln(bufnr)
    if sln_dir then
        on_dir(sln_dir)
        return
    end

    local proj_dir = vim.fs.root(bufnr, function(fname)
        return has_ext(fname, 'csproj')
    end)

    if proj_dir then
        on_dir(proj_dir)
    end
end

---@type vim.lsp.Config
return { root_dir = find_root_dir }
