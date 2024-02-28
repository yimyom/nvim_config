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


