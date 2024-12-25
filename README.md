# NeoVim Configuration for Python and Go

This repository contains a working Neovim configuration based on [NvChad](https://nvchad.com/), with custom modifications and additional plugins.

## Prerequisites

- Neovim >= 0.9.0
- Git
- A [Nerd Font](https://www.nerdfonts.com/) (Optional but recommended)
- `ripgrep` for telescope file search (Optional)
- A terminal that supports true colors
- Go >= 1.19 (for Go development)
- Python >= 3.8 (for Python development)
- Node.js >= 16 (for certain LSP servers)
- `gcc` or `clang` (for treesitter compilation)

### Python Requirements
The setup script will install these automatically with specific versions:
- python-lsp-server
- mypy
- ruff

### Go Requirements
The setup script will check and install if missing:
- golines
- goimports-reviser (v3)
- Other Go tools will be installed via Mason

## Installation

1. Backup your existing Neovim configuration (if any):
```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
```

2. Clone this configuration:
```bash
git clone https://github.com/rolandtannous/nvim-config ~/.config/nvim --depth 1
```

3. Run the setup script:
```bash
cd ~/.config/nvim
./setup.sh
```

4. Start neovim and Run
```bash
:Lazy sync
:MasonInstallAll
:TSUpdate
```

This script will:
- Install required Go packages if missing
- Set up Python dependencies with specific versions
- Configure necessary language servers


## Features

### Core Features
- Based on NvChad for optimal performance and aesthetics
- Optimized for Python and Go development
- Custom statusline and UI enhancements
- Integrated terminal and file navigation

### Development Features
- LSP (Language Server Protocol) support:
  - Autocompletion
  - Code navigation
  - Error diagnostics
  - Symbol search
- Advanced debugging capabilities:
  - Python debugging via debugpy
  - Go debugging with DAP
  - Breakpoint management
  - Variable inspection
- Code formatting and linting:
  - Python: black, ruff, mypy
  - Go: gofmt, golines, goimports-reviser

### Additional Tools
- ChatGPT integration for AI assistance
- Avante Copilot support (Currently uses Sonnet 3.5)
- Markdown preview with image support
- Custom clipboard management
- Git integration with diffview
- Fuzzy finding with Telescope

## Structure

```
.
├── init.lua
├── requirements.txt
├── setup.sh
└── lua/
    ├── core/
    ├── plugins/
    └── custom/
        ├── chadrc.lua
        ├── mappings.lua
        ├── plugins.lua
        └── configs/
            ├── avante.lua
            ├── dap.lua
            ├── formatter.lua
            ├── img-clip.lua
            ├── lint.lua
            ├── lspconfig.lua
            └── null-ls.lua
```

## Key Mappings

### General
- `<leader>` key is set to space
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>b` - Buffer management
- `<Esc>` - Clear search highlights

### LSP
- `gd` - Go to definition
- `gr` - Find references
- `K` - Show hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol

### Debug
- `<leader>db` - Toggle breakpoint
- `<leader>dc` - Start/Continue debug
- `<leader>dt` - Terminate debug session
- `<leader>do` - Step over
- `<leader>di` - Step into

### Git
- `<leader>gs` - Git status
- `<leader>gd` - Git diff view
- `<leader>gb` - Git blame

### Terminal
- `<A-i>` - Toggle floating terminal
- `<A-h>` - Toggle horizontal terminal
- `<A-v>` - Toggle vertical terminal

For a complete list of keymaps, check `:help keymaps` or view the `mappings.lua` file.

## Updating

To pull latest custom configuration:
```bash
cd ~/.config/nvim
git pull
```



## Troubleshooting

If you encounter any issues:
1. Update Neovim to the latest version
2. Update the configuration

Alternatively just clean and rebuild.

## Contributing

Feel free to open issues or submit pull requests if you have suggestions for improvements.
