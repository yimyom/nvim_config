return {

-- Color scheme
{'rebelot/kanagawa.nvim', priority = 1000,
    config = function()
        vim.cmd([[colorscheme kanagawa]])
    end
},

-- UI User Interface plugins
{'lukas-reineke/indent-blankline.nvim', main='ibl', -- indent lines
    config = function()
        require('ibl').setup({
            scope = { enabled = true },
        })
        end
},

{'nvim-lualine/lualine.nvim',
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

} -- end of return
