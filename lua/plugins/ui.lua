-- This file is part of nvim_config.
-- nvim_config is free software: you can redistribute it and/or modify it under the terms of the
-- GNU General Public License as published by the Free Software Foundation, either version 3 of
-- the License, or (at your option) any later version. nvim_config is distributed in the hope 
-- that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details. You should have received a copy of the GNU General Public License along with
-- nvim_config. If not, see <https://www.gnu.org/licenses/>.

return {

----------------------------------
-- Colorscheme
----------------------------------

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
	end,
},

{'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
	config = function()
		-- vim.cmd.colorscheme('tokyonight')
	end,
},

{'sainnhe/sonokai',
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.sonokai_enable_italic = true
		-- vim.cmd.colorscheme('sonokai')
    end
},

{'neanias/everforest-nvim',
	version = false,
	lazy = false,
	priority = 1000,
	config = function()
		-- vim.cmd.colorscheme('everforest')
	end,
},

-- --------------------------------
-- UI User Interface plugins
-- --------------------------------

-- snacks.vim is a large plugin with many smaller plugins inside
{'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts =
    {
        dashboard = { enabled = true, },
        indent =
        {
            enabled = true,
            animate = { enabled = false, },
        },
        explorer = { enabled = true },
        picker = { enabled = true },
        input = { enabled = true },
        toggle = { },
    },
    keys =
    {
        -- u for Utilities
        { '<leader>uf', function() Snacks.explorer() end, mode='n', noremap=true, silent=true, desc='File manager' },
        { '<leader>uc', function() Snacks.picker.colorschemes() end, mode='n', noremap=true, silent=true, desc='Color schemes' },
        { '<leader>um', function() Snacks.picker.man() end, mode='n', noremap=true, silent=true, desc='Man pages' },
        -- b for Buffers
        { '<leader>bl', function() Snacks.picker.buffers() end, mode = 'n', noremap=true, silent=true, desc='List buffers'},
        { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
        -- g for Git
        { '<leader>gt', function() Snacks.picker.git_status() end, desc = 'Git status' },
        { '<leader>gD', function() Snacks.picker.git_diff() end, desc = 'Git diff' },
    },
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

-- {'gelguy/wilder.nvim',
--     event = 'BufEnter',
--     config = function()
--         local wilder = require('wilder')
--         wilder.setup({
--             modes = {':', '/', '?'},
--             enable_cmdline_enter = 0,
--         })
--
--         local gradient = {
--         '#f4468f', '#fd4a85', '#ff507a', '#ff566f', '#ff5e63',
--         '#ff6658', '#ff704e', '#ff7a45', '#ff843d', '#ff9036',
--         '#f89b31', '#efa72f', '#e6b32e', '#dcbe30', '#d2c934',
--         '#c8d43a', '#bfde43', '#b6e84e', '#aff05b'
--         }
--
--         for i, fg in ipairs(gradient) do
--             gradient[i] = wilder.make_hl('WilderGradient' .. i, 'Pmenu', {{a = 1}, {a = 1}, {foreground = fg}})
--         end
--
--         local popmenu_renderer = wilder.popupmenu_renderer(
--             wilder.popupmenu_border_theme({
--                 highlighter = wilder.highlighter_with_gradient({wilder.basic_highlighter(), }),
--                 highlights = { gradient = gradient, },
--                 left = {' ', wilder.popupmenu_devicons()},
--                 right= {' ', wilder.popupmenu_scrollbar()},
--                 pumblend=10,
--             })
--         )
--
--         local wildmenu_renderer = wilder.wildmenu_renderer({
--             highligher = {
--                 wilder.pcre2_highlighter(),
--                 wilder.lua_fzy_highlighter(),
--             }
--         })
--
--         local renderer = wilder.renderer_mux({
--             [':'] = popmenu_renderer,
--             ['/'] = wildmenu_renderer,
--         })
--
--         wilder.set_option('renderer', renderer)
--     end,
-- },

{'folke/which-key.nvim', -- preview complex key mapping
    event = 'VeryLazy',
    opts =
    {
        spec =
        {
            { lhs = '<leader>b', group = 'Buffers', desc = 'Buffers' },
            { lhs = '<leader>l', group = 'LSP and languages', desc = 'LSP and languages' },
            { lhs = '<leader>g', group = 'Git', desc = 'Git' },
        }
    },
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
},

} -- end of return
