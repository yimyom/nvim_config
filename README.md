# nvim_config

An efficient neovim config for programmers and academics.

# Installation

I usually clone the project and create a symbolic link from `${HOME}/.config/nvim` to the `nvim_config` directory.
Doing so, every time `nvim_config` is updated with `git pull`, there is no need to re-install it.

When the files are deployed as explained above, the first start of neovim will load and install all the plugins.
This procedure can take some time depending on your machine and internet speed connection. On my machine, it takes
less than a minute anyway.

Then you will notice that `Treesitter` installs all the required languages grammars and Mason will install the required
language servers. If you need to check the language servers or install more, call `:Mason` in neovim.

## Simple installation procedure
```bash
cd
git clone https://github.com/yimyom/nvim_config
mkdir -p ~/.config/
ln -s ~/nvim_config .nvim
```

Of course, you might want to put the git repository somewhere else. In that case, you need to adapt the paths in the litle script above.

# Directory structure

- `init.lua`: set the basic parameters, load `lazy.vim` the plugins manager
- `lua/` contains config files and the `plugins` directory.
- `lua/plugins`: config files for all the neovim plugins


# Vi configuration
- Install `lazy` package manager automatically
- Folding is done using Treesitter expressions
- Tabs are 4 spaces with smart indent
- When opening a terminal, the terminal becomes active immediately. Same when moving the cursor into an active terminal.
  Use `esc` to go back to normal mode from a terminal

## Keyboard shortcuts

`\` is the _&lt;leader&gt;_ key.

|  Category                |  Keys        |  Description                                          |
|:-------------------------|:------------:|:------------------------------------------------------|
| Utils                    |              |                                                       |
|                          |   **\f**     | File manager                                          |
|                          |   **\bl**    | Buffer manager                                        |
|                          |   **\bc**    | Close buffer                                          |
| Git                      |              |                                                       |
|                          |   **\gb**    | Blame line                                            |
|                          |   **\gn**    | Next git hunk                                         |
|                          |   **\gd**    | Diff this with the previous head (HEAD~1)             |
|                          |   **\gp**    | Previous git hunk                                     |
|                          |   **\gf**    | Stage buffer                                          |
|                          |   **\gs**    | Stage hunk under the cursor                           |
|                          |   **\gi**    | Preview git hunk inline                               |
|                          |   **\gv**    | Preview git hunk                                      |
|                          |   **\gl**    | Open the quickfix window with git changes             |
| Languages and LSP        |              |                                                       |
|                          |   **\ld**    | Jump to the definition of the symbol under the cursor |
|                          |   **\ln**    | C++ symbol information (from clangd)                  |
|                          |   **\le**    | C++ type hierarchy (from clangd)                      |
|                          |   **\lr**    | Rename symbol                                         |
|                          |   **\lh**    | Symbol help information                               |
|                          |   **\ls**    | Symbol signature help                                 |
|                          |   **\li**    | Symbol implementation                                 |
|                          |   **\lt**    | Symbol type definition                                |
| Troubles and diagnostics |              |                                                       |
|                          |   **\td**    | Open document diagnostics window                      | 
|                          |   **\tx**    | Open Trouble window                                   |
|                          |   **\tl**    | Open location list                                    |
|                          |   **\tq**    | Open QuickFix window                                  |
|                          |   **\tw**    | Open workspace diagnostics window                     |
  
# About the plugins

## User interface
- nvim-web-devicons: to display nice icons everywhere, like the top bar, status bar,
  file manager, etc...
- catpuccin, tokyonight: nice colorschemes
- indent-blankline: add vertical indent lines to your programs to help understaning
  the structure of your code
- lualine: the status bar is enhanced
- barbar: a top bar with the open tabs: you can click, move them, close them, reorder
  them
- wilder: a nicer pop-up menu when in command mode
 - when you press <TAB> a pop-up menu will appear with possible choices when you're on the command line (`:`).
 - when in search mode (`/` or `?`), the status bar will contain the possible completions instead of having a pop-up menu which overlaps the main text window
- trouble: open the quick fix window with all the problems in your code

# Utilities

# Languages support
## LSP
## Extra configuration's files
### R Language
In the `dotfiles` directory, there is a file called `.lintr` which need to be placed
in your home directory. It contains extra configuration for the R linter to avoid having too many messages on the screen. Depending on your preferences you might want to change this file.

I recommend linking the file directly from the git repository so that next time I update it, you can simply do `git pull` to get the latest version and everything will be update for you.

Let's assume the git repository is in `${HOME}/nvim_config`:

```bash
ln -s ${HOME}/nvim_config/dotfiles/.lintr ${HOME}
```

Next, to have a more advanced configuration, refer to the [`lintr` documentation](https://cran.r-project.org/web/packages/lintr/vignettes/lintr.html).
