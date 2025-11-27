# Vim Migration Guide: vim-lsp + ale Setup

## Overview

This setup provides a lightweight alternative to Neovim's native LSP using:
- **vim-lsp**: LSP client for Vim
- **vim-lsp-settings**: Auto-installer for LSP servers (like Mason)
- **ale**: Asynchronous linting and formatting
- **asyncomplete**: Async completion framework
- **fzf.vim**: Fuzzy finding (replaces Telescope)

## Installation Steps

### 1. Install Vim 8.2+
```bash
# Check version
vim --version | head -1

# Should be 8.2 or higher
# On macOS: brew install vim
# On Ubuntu: sudo apt install vim-gtk3
```

### 2. Install vim-plug
```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### 3. Install external dependencies
```bash
# fzf (required for fuzzy finding)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# ripgrep (for live grep)
# macOS:
brew install ripgrep

# Ubuntu:
sudo apt install ripgrep

# bat (for fzf preview - optional)
# macOS:
brew install bat

# Ubuntu:
sudo apt install bat
# Note: might be named 'batcat' on Ubuntu
```

### 4. Install formatters/linters (matching your conform.nvim setup)
```bash
# Go
go install mvdan.cc/gofumpt@latest

# Python
pip install ruff

# Lua
# macOS:
brew install stylua
# Or cargo:
cargo install stylua

# Shell
# macOS:
brew install shfmt shellcheck
# Ubuntu:
sudo apt install shfmt shellcheck

# JSON
# macOS:
brew install jq
# Ubuntu:
sudo apt install jq

# Others as needed
```

### 5. Copy the vimrc
```bash
# Backup existing config
mv ~/.vimrc ~/.vimrc.backup 2>/dev/null

# Copy new config
cp /tmp/vimrc-preview.vim ~/.vimrc
```

### 6. Install plugins
```bash
vim +PlugInstall +qall
```

### 7. LSP servers will auto-install
When you open a file, vim-lsp-settings will prompt to install the LSP server.
You can also manually install:
```vim
:LspInstallServer
```

## Feature Comparison

| Feature | Neovim Setup | Vim Setup | Notes |
|---------|-------------|-----------|-------|
| **LSP Client** | Native LSP | vim-lsp | Slightly slower, but works well |
| **LSP Auto-install** | Mason | vim-lsp-settings | Auto-prompts on file open |
| **Completion** | blink.cmp | asyncomplete | Simpler, less smart |
| **Formatting** | conform.nvim | ale | ale does both linting + formatting |
| **Linting** | Via LSP | ale + LSP | ale shows more linters |
| **Fuzzy Find** | Telescope | fzf.vim | fzf is faster, less features |
| **Git Signs** | gitsigns.nvim | vim-gitgutter | Similar functionality |
| **Syntax** | Treesitter | Built-in | Regex-based, still good |
| **File Explorer** | oil.nvim | netrw (built-in) | netrw works, or add NERDTree |

## Key Differences

### Completion
**Neovim (blink.cmp):**
- Snippet expansion with LuaSnip
- Smart auto-brackets
- Very fast with native LSP

**Vim (asyncomplete):**
- Simpler completion menu
- No snippet expansion (unless you add vim-vsnip)
- Press Tab to cycle, Enter to confirm

### LSP Features
All major LSP features work:
- ✅ Go to definition/references
- ✅ Hover documentation
- ✅ Rename
- ✅ Code actions
- ✅ Diagnostics
- ✅ Auto-formatting

**Differences:**
- Slightly slower response time
- vim-lsp doesn't support all LSP 3.17 features
- No semantic token highlighting (you disabled this anyway)

### Fuzzy Finding (fzf vs Telescope)

**Your Telescope Keymaps → fzf Equivalents:**
- `<leader>sf` → `:Files` (find files)
- `<leader>sg` → `:GFiles` (git files)
- `<leader>sa` → `:AllFiles` (all files including untracked)
- `<leader>ss` → `:Rg` (live grep)
- `<leader>st` → `:RgWord` (grep word under cursor)
- `<leader>sp` → `:RgRoot` (grep in git root)
- `<leader>ls` → `:Buffers` (buffer list)
- `<leader>sh` → `:Helptags`
- `<leader>km` → `:Maps` (keymaps)

**fzf advantages:**
- Faster startup
- Native speed (C-based)

**fzf limitations:**
- No live preview like Telescope
- Less customizable UI
- No multi-window preview layout

## LSP Servers Supported

These will auto-install via vim-lsp-settings (matching your Mason list):

- ✅ ansiblels (Ansible)
- ✅ bash-language-server
- ✅ docker-langserver
- ✅ gopls (Go)
- ✅ json-languageserver
- ✅ lua-language-server
- ✅ marksman (Markdown)
- ✅ omnisharp (C#/.NET)
- ✅ pyright (Python)
- ✅ rust-analyzer (Rust)
- ✅ taplo (TOML)
- ✅ terraform-ls
- ✅ typescript-language-server
- ✅ yaml-language-server

**Not available/different:**
- regal (Rego) - limited vim-lsp support
- ruff - works via ale for linting/formatting

## Testing the Setup

### 1. Test LSP
```bash
# Open a Go file
vim test.go
```

When prompted, accept LSP server installation. Then:
- Press `K` on a symbol → should show hover info
- Press `gd` → should go to definition
- Type something and see completion popup

### 2. Test formatting
```bash
# Open a Python file
vim test.py
```

Make some formatting errors, then `:w` to save.
ale should auto-format on save.

### 3. Test fuzzy finding
```bash
vim
```
Then:
- `<leader>sf` → should open file finder
- Type to filter, Enter to open
- `<leader>ss` → should open ripgrep search

### 4. Test Git integration
```bash
cd ~/your-git-repo
vim somefile.txt
```

Make changes:
- Should see `+` signs in gutter for additions
- `]c` / `[c` to jump between changes
- `<leader>hp` to preview hunk
- `<leader>hs` to stage hunk

## Troubleshooting

### LSP server won't install
```vim
:LspInstallServer <server-name>
" Example: :LspInstallServer gopls
```

### Completion not working
```vim
" Check if LSP is running
:LspStatus

" Should show attached servers
" If not, check :messages for errors
```

### ale not formatting
```vim
" Check ale fixers
:ALEInfo

" Manually format
:ALEFix

" Check if format-on-save is enabled
:echo g:ale_fix_on_save
" Should be 1
```

### fzf not finding files
```bash
# Install fzf and ripgrep
# See installation steps above

# Test from command line
rg --version
fzf --version
```

## Customization

### Add more LSP servers
Edit the vim-lsp setup section in `.vimrc`. Example for a custom server:

```vim
if executable('my-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'my-server',
        \ 'cmd': {server_info->['my-language-server']},
        \ 'allowlist': ['myfiletype'],
        \ })
endif
```

### Add more ale linters/fixers
```vim
let g:ale_linters = {
\   'python': ['ruff', 'pyright', 'mypy'],
\}

let g:ale_fixers = {
\   'python': ['black', 'isort'],
\}
```

### Change fzf layout
```vim
" Fullscreen with preview
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

" Or popup in center
let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.4, 'yoffset': 0.5 } }
```

## Performance Comparison

**Startup time:**
- Neovim with lazy.nvim: ~50-100ms
- Vim with vim-plug (lazy loading): ~40-80ms

**LSP response:**
- Neovim native LSP: ~10-50ms
- vim-lsp: ~20-100ms (still very usable)

**Memory usage:**
- Neovim: ~30-50MB base
- Vim: ~15-30MB base

## What You Lose

1. **Treesitter** - No AST-based highlighting/navigation
   - Built-in regex syntax works for 95% of cases
   
2. **Lua scripting** - Everything is Vimscript
   - Vimscript is more verbose but capable
   
3. **Fastest LSP** - vim-lsp is slower than native
   - Still fast enough for smooth workflow
   
4. **Modern UI** - No floating windows like Telescope
   - fzf is still very good, just different

5. **Copilot Chat** - CopilotChat.nvim is Neovim-only
   - Regular copilot.vim still works for completions

6. **DAP debugging** - nvim-dap is Neovim-only
   - Could use vimspector as alternative (not included)

## What You Gain

1. **Simplicity** - Fewer dependencies, simpler stack
2. **Stability** - Vim is very stable, plugins are mature
3. **Universality** - Vim is installed everywhere
4. **Speed** - Vim starts faster than Neovim
5. **Vimscript mastery** - One language for everything

## Next Steps

1. **Try it out**: Use for a week, see if it fits your workflow
2. **Add snippets**: Consider adding vim-vsnip if you miss snippets
3. **File explorer**: Try NERDTree if you prefer a sidebar over netrw
4. **Debugging**: Add vimspector if you need DAP-like debugging

## Reverting

To go back to Neovim:
```bash
# Restore old vimrc if needed
mv ~/.vimrc.backup ~/.vimrc

# Keep using Neovim
nvim
```

Both configs can coexist - Vim uses `~/.vimrc`, Neovim uses `~/.config/nvim/`.
