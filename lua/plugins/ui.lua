-- This file is part of nvim_config.
-- nvim_config is free software: you can redistribute it and/or modify it under the terms of the
-- GNU General Public License as published by the Free Software Foundation, either version 3 of
-- the License, or (at your option) any later version. nvim_config is distributed in the hope 
-- that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details. You should have received a copy of the GNU General Public License along with
-- nvim_config. If not, see <https://www.gnu.org/licenses/>.

-- Plugins working automatically without invokation from the user
return {

{'nvim-tree/nvim-web-devicons', -- Glyphs and Icons for neovim
    lazy = true
},

{'catppuccin/nvim',
    lazy = false,
    priority = 1000,
    name = 'catppuccin',
    event = {"BufReadPre","BufNewFile"},
    opts = {
        flavour = 'mocha',
        term_colors = true,
        no_italic = true,
        no_bold = true,
        styles = {
            comments = {'italic'}
        },
    },
    integrations = {
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = {'italic'},
                hints = {'italic'},
                warnings = {'italic'},
                information = {'italic'},
            },
        },
    },
    config = function()
        vim.cmd.colorscheme('catppuccin')
    end
},

{'folke/tokyonight.nvim',
    priority = 1000,
    opts = {},
},

-- UI User Interface plugins
{'lukas-reineke/indent-blankline.nvim', -- indent lines
    event = {'BufReadPre', 'BufNewFile'},
    main='ibl',
    opts = {
        indent = {
            char = "▏",
        },
        scope = {
            enabled = true,
        },
    }
},

{'nvim-lualine/lualine.nvim',
    lazy = false,
    opts =
    {
        options =
        {
            theme = 'ayu_dark',
            component_separators = '|',
            section_separators = { left = '', right = '' },
            sections = {
                lualine_a = {{'mode', separator = { left = '' }, right_padding = 2 },},
                lualine_b = {'filename', 'branch'},
                lualine_c = {'fileformat'},
                lualine_x = {},
                lualine_y = {'filetype', 'progress'},
                lualine_z = {{'location', separator = { right = '' }, left_padding = 2 },},},
            inactive_sections = {
                lualine_a = { 'filename' },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { 'location' },},
            tabline = {},
            extensions = {},
        }
    }
},

{'romgrk/barbar.nvim',
    dependencies =
    {
        'lewis6991/gitsigns.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts =
    {
    },
},

{'gelguy/wilder.nvim',
    opts = {
        modes = {':', '/', '?'},
    },
},

{'folke/trouble.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    keys = {
        {'<leader>tx', '<cmd>lua require("trouble").open()<cr>',
        noremap=true, silent=true, desc='Open Trouble window'},
        {'<leader>tw', '<cmd>lua require("trouble").open("workspace_diagnostics")<cr>',
        noremap=true, silent=true, desc='Open workspace diagnostics window'},
        {'<leader>td', '<cmd>lua require("trouble").open("document_diagnostics")<cr>',
        noremap=true, silent=true, desc='Open document diagnostics window'},
        {'<leader>tq', '<cmd>lua require("trouble").open("quickfix")<cr>',
        noremap=true, silent=true, desc='Open QuickFix window'},
        {'<leader>tl', '<cmd>lua require("trouble").open("loclist")<cr>',
        noremap=true, silent=true, desc='Open location list'},
    },
},


} -- end of return
