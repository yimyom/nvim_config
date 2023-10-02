-- Boostrap and load Lazy.nvim to manage the plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
	"https://github.com/folke/lazy.nvim.git",
	"--branch=stable", lazypath, })
end
vim.opt.rtp:prepend(lazypath)

-- General vi config
vim.o.backup = false    -- don't keep backup files
vim.o.mouse = 'a'       -- use the mouse
vim.o.number = true     -- line numbers on the left
vim.o.splitbelow = true -- always horizontaly split a window below the current active window
vim.o.splitright = true -- always vertically split a window right to the current active window
vim.o.updatetime = 1000 -- update the swap file once per second 

-- Color and theme options
vim.o.termguicolors = true              -- enable 24-bit RGB color
vim.o.background = 'dark'               -- prefer a dark theme color   
--vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1  - 

-- Disable netrw in favor of NVimTree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Use treesitter to determine the folding
vim.o.foldlevelstart = 20
vim.o.foldmethod='expr'
vim.o.foldexpr='nvim_treesitter#foldexpr()'
vim.o.foldtext= [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]

-- Auto-completion
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert', 'preview'}
vim.opt.shortmess = vim.opt.shortmess + { c = true }

-- Indentation options
--vim.o.smartindent = true
vim.o.cindent = true
vim.o.cinoptions='>s,e0,n0,f0,{1s,}0,^0,L-1,:s,=s,l0,b0,gs,hs,N0,E0,ps,ts,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,k0,m0,j0,J0,)20,*70,#0,P0'
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

-- in Terminal: <Esc> goes back to command mode
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

-- Go directly into command line, no need for i (insert)
vim.api.nvim_create_autocmd("BufWinEnter",
{
    pattern = "term://*",
    callback = function()
        vim.cmd('startinsert')
    end,
})

vim.api.nvim_create_autocmd("WinEnter",
{
    pattern = "term://*",
    callback = function()
        vim.cmd('startinsert')
    end,
})

vim.api.nvim_create_autocmd("TermOpen",
{
    pattern = "term://*",
    callback = function()
        vim.cmd('startinsert')
    end,
})

-- Automatically close tab/vim when nvim-tree is the last window in the tab
vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

-- Load plugins
require('lazy').setup('plugins', { defaults = { lazy = false, }, })
