-- This file is part of nvim_config.
-- nvim_config is free software: you can redistribute it and/or modify it under the terms of the
-- GNU General Public License as published by the Free Software Foundation, either version 3 of
-- the License, or (at your option) any later version. nvim_config is distributed in the hope 
-- that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details. You should have received a copy of the GNU General Public License along with
-- nvim_config. If not, see <https://www.gnu.org/licenses/>.

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
local lazy_opts = 
{
    spec = 'plugins', 
    {
        defaults = { lazy = true, }, 
        checker =
        {
            enable = true,
            notify = true,
            frequency = 3600*24,
        },
    }
}
require('lazy').setup(lazy_opts, {})
