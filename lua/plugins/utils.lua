-- This file is part of nvim_config.
-- nvim_config is free software: you can redistribute it and/or modify it under the terms of the
-- GNU General Public License as published by the Free Software Foundation, either version 3 of
-- the License, or (at your option) any later version. nvim_config is distributed in the hope 
-- that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details. You should have received a copy of the GNU General Public License along with
-- nvim_config. If not, see <https://www.gnu.org/licenses/>.

-- Various plugins with invokation from the user

return {

-- General
{'nvim-lua/plenary.nvim', -- generic functions
    lazy = true,
},

-- Utils
{'samjwill/nvim-unception', -- open a file in vi from a nested term (no nested vi)
},

{'j-morano/buffer_manager.nvim', -- buffer manager in a floating window
    keys = {
        {'<leader>b', '<cmd>lua require("buffer_manager.ui").toggle_quick_menu()<cr>', mode = 'n', noremap=true, silent=true, desc='Buffer manager'}
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
                ['<leader>l'] = { name = '+LSP and languages' },
                ['<leader>g'] = { name = '+Git' },
                ['<leader>t'] = { name = '+Trouble and diagnostics' },
            }
        wk.register(keymaps)
    end,
},

{'nvim-tree/nvim-tree.lua', -- file manager
    opts = {
        sort_by = 'case_sensitive',
        on_attach = on_attach_nvim_tree,
        view = { number = true }
    },
    keys = {
        { '<leader>f', '<cmd>NvimTreeToggle<cr>', mode='n', noremap=true, silent=true, desc='File manager' }
    },
},

{'lewis6991/gitsigns.nvim', -- Git signs in the vi gutter (+ on status line)
    event = "VeryLazy",
    opts = {
         signs = {
            add = { text = " " }, 
            change = { text = " " }, 
            delete = { text = " " }, 
            topdelete = { text = "‾" },
            changedelete = { text= "~" },
            untracked = { text = "┆" },
        },
        --signs = {
        --    add         ={hl='GitSignsAdd'   ,text='+',numhl='GitSignsAddNr'   ,linehl='GitSignsAddLn'},
        --    change      ={hl='GitSignsChange',text='~',numhl='GitSignsChangeNr',linehl='GitSignsChangeLn'},
        --    delete      ={hl='GitSignsDelete',text='-',numhl='GitSignsDeleteNr',linehl='GitSignsDeleteLn'},
        --    topdelete   ={hl='GitSignsDelete',text='‾',numhl='GitSignsDeleteNr',linehl='GitSignsDeleteLn'},
        --    changedelete={hl='GitSignsChange',text='~',numhl='GitSignsChangeNr',linehl='GitSignsChangeLn'},
        --},
        preview_config = { border = 'rounded', },
    },
    keys = {
		{'<leader>gp', '<cmd>Gitsigns prev_hunk<cr>', mode='n', noremap=true, silent=true, desc='Previous git hunk'},
		{'<leader>gn', '<cmd>Gitsigns next_hunk<cr>', mode='n', noremap=true, silent=true, desc='Next git hunk'},
		{'<leader>gb', '<cmd>Gitsigns blame_line<cr>', mode='n', noremap=true, silent=true, desc='Blame line'},
		{'<leader>gd', '<cmd>Gitsigns diffthis<cr>', mode='n', noremap=true, silent=true, desc='Diff this with the previous head (HEAD~1)'},
		{'<leader>gv', '<cmd>Gitsigns preview_hunk<cr>', mode='n', noremap=true, silent=true, desc='Preview git hunk'},
		{'<leader>gi', '<cmd>Gitsigns preview_hunk_inline<cr>', mode='n', noremap=true, silent=true, desc='Preview git hunk inline'},
		{'<leader>gs', '<cmd>Gitsigns stage_hunk<cr>', mode='n', noremap=true, silent=true, desc='Stage hunk under the cursor'},
		{'<leader>gf', '<cmd>gitsigns stage_buffer<cr>', mode='n', noremap=true, silent=true, desc='Stage buffer'},
        {'<leader>gl', '<cmd>Gitsigns setqflist<cr>', mode='n', noremap=true, silent=true, desc='Open the quickfix window with git changes'},
    },
},
} -- end of return
