-- This file is part of nvim_config.
-- nvim_config is free software: you can redistribute it and/or modify it under the terms of the
-- GNU General Public License as published by the Free Software Foundation, either version 3 of
-- the License, or (at your option) any later version. nvim_config is distributed in the hope 
-- that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details. You should have received a copy of the GNU General Public License along with
-- nvim_config. If not, see <https://www.gnu.org/licenses/>.

-- General vi config
vim.o.backup = false    -- don't keep backup files
vim.o.mouse = 'a'       -- use the mouse
vim.o.number = true     -- line numbers on the left
vim.o.splitbelow = true -- always horizontaly split a window below the current active window
vim.o.splitright = true -- always vertically split a window right to the current active window
vim.o.updatetime = 1000 -- update the swap file once per second 
vim.o.signcolumn = 'yes'-- keep the left gutter on at all time
vim.opt.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize'
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4

-- Color and theme options
vim.o.termguicolors = true              -- enable 24-bit RGB color
vim.o.background = 'dark'               -- prefer a dark theme color   
--vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1  - 

-- Automatically close tab/vim when nvim-tree is the last window in the tab
vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

vim.o.foldlevelstart = 99
vim.o.foldmethod='expr'
vim.o.foldexpr='nvim_treesitter#foldexpr()'
vim.o.foldtext= [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]

vim.o.smartindent = false
vim.o.cindent = false
vim.o.cinoptions='>s,e0,n0,f0,{1s,}0,^0,L-1,:s,=s,l0,b0,gs,hs,N0,E0,ps,ts,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,k0,m0,j0,J0,)20,*70,#0,P0'

-- Inline diagnostics (virtual text)
vim.diagnostic.config(
    {
        signs = true,         -- Keep gutter signs (E/W)
        virtual_text =
        {
            source = 'if_many',
            prefix = '●',
        },
})

vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { ctermfg = 1, fg = '#ff0000', italic = true })
vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { ctermfg = 3, fg = '#ffff00' })
