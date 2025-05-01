-- This file is part of nvim_config.
-- nvim_config is free software: you can redistribute it and/or modify it under the terms of the
-- GNU General Public License as published by the Free Software Foundation, either version 3 of
-- the License, or (at your option) any later version. nvim_config is distributed in the hope 
-- that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details. You should have received a copy of the GNU General Public License along with
-- nvim_config. If not, see <https://www.gnu.org/licenses/>.

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
