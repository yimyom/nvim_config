# nvim_config

A simple neovim config.
Clone this repository and put the files in `~/.config/nvim` (Linux) or the equivalent location on your operating system.

The directory structure is as follows:

- `init.lua`: set the basic parameters, load `lazy.vim` the plugins manager
- `lua/plugins`: it holds several files for configure the various plugins
- `lua/plugins/languages.lua`: config and plugins for programming languages (LSP, Treesitter, etc...)
- `lua/plugins/ui_utils_misc.lua`: all the other plugins used in this configuration

When the files are deployed as explained above, the first start of neovim will load and install all the plugins. This procedure can take some time depending on your machine and internet speed connection. On my machine, it takes less than a minute anyway.

# Features
# Vi configuration
- Install `lazy` package manager automatically
- Folding is done with Treesitter expressions
- Tabs are 4 spaces with smart indent
- When opening a terminal, the terminal becomes active immediately. Same when moving the cursor into an active terminal. Use `esc` to go back to normal mode from a terminal

## plugins

UI, utilies and misc. plugins
-----------------------------

| Plugins | Description |
| --------| ------------|
| plenary   | Functions used by other plugins. Required by many |
| nvim-unception | `vi` inside a vi-terminal will open in the parent vi, not in the terminal |
| which-key | Display key mappings when the first keys are pressed |
| Nvim Tree | File manager |
| Telescope | Fuzzy finder to search for just everything in real-time |
| Kanagawa  | A color scheme |
| Indent blankline | draw vertical lines to show indentations |
| lualine | a nice and advanced status line |
| gitsigns | put a left-column showing git modifications (+ other git features) |


## keyboard shortcuts
# TODO
