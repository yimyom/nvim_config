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
|                          |   **\gd**    | Diff this with the previous head (HEAD~1)             |
|                          |   **\gf**    | Stage buffer                                          |
|                          |   **\gi**    | Preview git hunk inline                               |
|                          |   **\gl**    | Open the quickfix window with git changes             |
|                          |   **\gn**    | Next git hunk                                         |
|                          |   **\gp**    | Previous git hunk                                     |
|                          |   **\gs**    | Stage hunk under the cursor                           |
|                          |   **\gv**    | Preview git hunk                                      |
| Programming              |              |                                                       |
|                          |   **\lo**    | List symbols                                          |
|                          |   **\ld**    | Jump to the definition of the symbol under the cursor |
|                          |   **\lh**    | Symbol help information                               |
|                          |   **\li**    | Symbol implementation                                 |
|                          |   **\ls**    | Symbol signature help                                 |
|                          |   **\lt**    | Symbol type definition                                |
|                          |   **\lr**    | Rename symbol                                         |
  
# About the plugins

## Color schemes
- [catpuccin](https://github.com/catppuccin/nvim) is the default
- [tokyonight](https://github.com/folke/tokyonight.nvim)
- [sonokai](https://github.com/sainnhe/sonokai)
- [everforest](https://github.com/neanias/everforest-nvim)

To change the default colorscheme, use the command `:Themery` to open a dialog box with all the available color sschemes.

# Languages support
## R Language
In the `dotfiles` directory, there is a file called `.lintr` which need to be placed
in your home directory. It contains extra configuration for the R linter to avoid having too many messages on the screen. Depending on your preferences you might want to change this file.

I recommend linking the file directly from the git repository so that next time I update it, you can simply do `git pull` to get the latest version and everything will be update for you.

Let's assume the git repository is in `${HOME}/nvim_config`:

```bash
ln -s ${HOME}/nvim_config/dotfiles/.lintr ${HOME}
```
Next, to have a more advanced configuration, refer to the [`lintr` documentation](https://cran.r-project.org/web/packages/lintr/vignettes/lintr.html).

## C++
`Clangd` is the default Language server.

## Python

