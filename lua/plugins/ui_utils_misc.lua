return {

-- General
'nvim-lua/plenary.nvim', -- generic functions

-- Utils
'samjwill/nvim-unception', -- open a file in vi from a nested term (no nested vi)

{'j-morano/buffer_manager.nvim', -- buffer manager in a floating window
    opts = { short_file_names = true, short_term_names = true },
    keys = { {'<leader>b', '<cmd>lua require("buffer_manager.ui").toggle_quick_menu()<cr>', mode = 'n', noremap=true, silent=true, desc='Buffer manager'} }
},

{'folke/which-key.nvim', -- preview complex key mapping
    event = 'VeryLazy',
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = { }
},

{'nvim-tree/nvim-tree.lua', -- file manager
    opts = {
        sort_by = 'case_sensitive',
        on_attach = on_attach_nvim_tree,
        view = { number = true }
    },
    keys = { { '<leader>f', '<cmd>NvimTreeToggle<cr>', mode='n', noremap=true, silent=true, desc='File manager' } },
},

-- 'nvim-telescope/telescope.nvim', -- Fuzzy finder

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

{'nvim-lualine/lualine.nvim', opts = {
    options = {
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
}}},

{'lewis6991/gitsigns.nvim', -- Git signs in the vi gutter (+ on status line)
    event = "VeryLazy",
    opts = {
        signs = {
            add         ={hl='GitSignsAdd'   ,text='+',numhl='GitSignsAddNr'   ,linehl='GitSignsAddLn'},
            change      ={hl='GitSignsChange',text='~',numhl='GitSignsChangeNr',linehl='GitSignsChangeLn'},
            delete      ={hl='GitSignsDelete',text='-',numhl='GitSignsDeleteNr',linehl='GitSignsDeleteLn'},
            topdelete   ={hl='GitSignsDelete',text='‾',numhl='GitSignsDeleteNr',linehl='GitSignsDeleteLn'},
            changedelete={hl='GitSignsChange',text='~',numhl='GitSignsChangeNr',linehl='GitSignsChangeLn'},
        },
        preview_config = { border = 'rounded', },
    },
    keys = {
		{'<leader>gp', '<cmd>Gitsigns prev_hunk<cr>', mode='n', noremap=true, silent=true, desc='previous git hunk'},
		{'<leader>gn', '<cmd>Gitsigns next_hunk<cr>', mode='n', noremap=true, silent=true, desc='next git hunk'},
		{'<leader>gb', '<cmd>Gitsigns blame_line<cr>', mode='n', noremap=true, silent=true, desc='blame line'},
		{'<leader>ga', '<cmd>Gitsigns toggle_current_line_blame<cr>', mode='n', noremap=true, silent=true, desc='toggle continuous blame line'},
		{'<leader>gd', '<cmd>Gitsigns diffthis<cr>', mode='n', noremap=true, silent=true, desc='diff this with previous head (HEAD~1)'},
		{'<leader>gv', '<cmd>Gitsigns preview_hunk<cr>', mode='n', noremap=true, silent=true, desc='preview git hunk'},
		{'<leader>gi', '<cmd>Gitsigns preview_hunk_inline<cr>', mode='n', noremap=true, silent=true, desc='preview git hunk inline'},
        {'<leader>gl', '<cmd>Gitsigns setqflist<cr>', mode='n', noremap=true, silent=true, desc='open location list'},
    },
},
} -- end of return {
