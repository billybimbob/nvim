# Neovim config

A Neovim configuration the way I like it, trying to use as many of the builtin Neovim defaults as possible.

## External dependencies

The plugins shell out to these. Neovim installs none of them.

| Needed by | Dependency |
| --- | --- |
| nvim-treesitter | tree-sitter CLI |
| nvim-treesitter | C compiler |
| telescope-fzf-native | C compiler |
| telescope | ripgrep |
| telescope | fd |
| nvim-web-devicons | [a Nerd Font](https://www.nerdfonts.com/) |

### Windows (winget)

```powershell
winget install Git.Git
winget install tree-sitter.tree-sitter-cli
winget install BurntSushi.ripgrep.MSVC
winget install sharkdp.fd
winget install BrechtSanders.WinLibs.POSIX.UCRT   # gcc + mingw32-make
```

### Debian / Ubuntu (apt)

```bash
apt install build-essential ripgrep fd-find
```
