-- This file is part of nvim_config.
-- nvim_config is free software: you can redistribute it and/or modify it under the terms of the
-- GNU General Public License as published by the Free Software Foundation, either version 3 of
-- the License, or (at your option) any later version. nvim_config is distributed in the hope 
-- that it will be useful, but WITHOUT ANY WARRANTY; with-ignout even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details. You should have received a copy of the GNU General Public License along with
-- nvim_config. If not, see <https://www.gnu.org/licenses/>.

return {

{'mfussenegger/nvim-dap',
    lazy = true,
    dependencies =
    {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'jay-babu/mason-nvim-dap.nvim',
    },
    opts =
    {
        signs =
        {
            breakpoint = { text = '🟡' },
            breakpoint_condition = { text = '🔴' },
            logpoint = { text = '📝' },
            stopped = { text = '▶️' },
        },
    },
},

{'rcarriga/nvim-dap-ui',
},

{'theHamsta/nvim-dap-virtual-text',
},

{'jay-babu/mason-nvim-dap.nvim',
    dependencies = 'mason.nvim',
    cmd = { 'DapInstall', 'DapUninstall' },
    opts =
    {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    handlers = {},

    -- You'll need to check that you have the required things installed
    -- online, please don't ask me how to install them :)
    ensure_installed =
    {
        -- Update this to ensure that you have the debuggers for the langs you want
    },
    },
    -- mason-nvim-dap is loaded when nvim-dap loads
    config = function() end,
},

}
