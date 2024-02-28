-- Boostrap and load Lazy.nvim to manage the plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
	"https://github.com/folke/lazy.nvim.git",
	"--branch=stable", lazypath, })
end
vim.opt.rtp:prepend(lazypath)

-- Load configuration
require('config')
require('terminal')

-- Load plugins
require('lazy').setup('plugins', { defaults = { lazy = true, }, })
