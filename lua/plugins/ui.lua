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
    lazy = false,
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
},

-- UI User Interface plugins
{'lukas-reineke/indent-blankline.nvim', -- indent lines
    event = {'BufReadPre', 'BufNewFile'},
    main='ibl',
    opts = {
        indent = { char = "▏", },
        scope = { enabled = true, },
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
    lazy = false,
    keys = {
        {'<leader>bl', '<cmd>lua require("buffer_manager.ui").toggle_quick_menu()<cr>',
                mode = 'n', noremap=true, silent=true, desc='Buffer manager'},
        {'<leader>bc', '<cmd>BufferClose<cr>', mode = 'n', noremap=true, silent=true, desc='Close buffer'},
    },
    opts =
    {
        auto_hide = 2,
        tabpages = true,
        clickable = true,
        hide = { inactive = true, },
        highlight_visible = true,
    },
    init = function() vim.g.barbar_auto_setup = false end,
},

{'gelguy/wilder.nvim',
    event = 'BufEnter',
    config = function()
        local wilder = require('wilder')
        wilder.setup({modes = {':', '/', '?'}})

        local renderer = wilder.popupmenu_renderer(
            wilder.popupmenu_border_theme(
            {
                highlights =
                {
                    border = 'Normal',
                },
                border = 'rounded',
                pumblend=10,
                left = {' ', wilder.popupmenu_devicons()},
                right= {' ', wilder.popupmenu_scrollbar()},
            }))

        wilder.set_option('renderer', renderer)
        end,
},

{'j-morano/buffer_manager.nvim', -- buffer manager in a floating window
    keys = {
        {'<leader>bl', '<cmd>lua require("buffer_manager.ui").toggle_quick_menu()<cr>', mode = 'n', noremap=true, silent=true, desc='Buffer manager'}
    },
    opts = {
        short_file_names = true,
        short_term_names = true
    },
},

{'folke/which-key.nvim', -- preview complex key mapping
    event = 'VeryLazy',
    opts = {
        window = {
            border = 'rounded',
        },
    },
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function(_,opts)
        local wk = require('which-key')
        wk.setup(opts)
        local keymaps = {
                ['<leader>b'] = { name = 'Buffers' },
                ['<leader>l'] = { name = 'LSP and languages' },
                ['<leader>g'] = { name = 'Git' },
                ['<leader>t'] = { name = 'Trouble and diagnostics' },
            }
        wk.register(keymaps)
    end,
},

} -- end of return
