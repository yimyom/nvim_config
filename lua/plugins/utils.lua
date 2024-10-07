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

-- --------------------------------
-- General
-- --------------------------------

{'nvim-lua/plenary.nvim', -- generic functions
    lazy = false,
},

-- --------------------------------
-- Utilities
-- --------------------------------

{'samjwill/nvim-unception', -- open a file in vi from a nested term (no nested vi)
    lazy = false,
},

-- {'folke/trouble.nvim',
--     keys = {
--         {'<leader>tx', '<cmd>lua require("trouble").open()<cr>', noremap=true, silent=true, desc='Open Trouble window'},
--         {'<leader>tw', '<cmd>lua require("trouble").open("workspace_diagnostics")<cr>', noremap=true, silent=true, desc='Open workspace diagnostics window'},
--         {'<leader>td', '<cmd>lua require("trouble").open("document_diagnostics")<cr>', noremap=true, silent=true, desc='Open document diagnostics window'},
--         {'<leader>tq', '<cmd>lua require("trouble").open("quickfix")<cr>', noremap=true, silent=true, desc='Open QuickFix window'},
--         {'<leader>tl', '<cmd>lua require("trouble").open("loclist")<cr>', noremap=true, silent=true, desc='Open location list'},
--     },
-- },

{'nvim-neo-tree/neo-tree.nvim',
    lazy = true,
    cmd = 'Neotree',
    dependencies =
    {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
        {
            's1n7ax/nvim-window-picker',
            opts =
            {
                filter_rules =
                {
                    include_current_win = false,
                    autoselect_one = true,
                    -- filter using buffer options
                    bo =
                    {
                        -- if the file type is one of following, the window will be ignored
                        filetype = {'neo-tree', 'neo-tree-popup', 'notify'},
                        -- if the buffer type is one of following, the window will be ignored
                        buftype = {'quickfix'},
                    },
                },
           },
        },
    },
    opts =
    {
        close_if_last_window = true,
        use_popups_for_input = false,
        popup_border_style = 'rounded',
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
        use_libuv_file_watcher = true,

        event_handlers =
        {
            event = "neo_tree_buffer_enter",
            handler = function(arg)
                vim.cmd([[
                    setlocal number
                ]])
--                vim.opt_local.number = true
--                vim.opt_local.relativenumber = true
            end,
        },
    },
    keys = {
        { '<leader>f', '<cmd>Neotree toggle<cr>: set number<cr>', mode='n', noremap=true, silent=true, desc='File manager' }
    },
},

{'lewis6991/gitsigns.nvim', -- Git signs in the vi gutter (+ on status line)
    event = {'BufReadPre','BufNewFile'},
    opts = {
         signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "-" },
            topdelete = { text = "‾" },
            changedelete = { text= "~" },
            untracked = { text = "┆" },
        },
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

-- {'niuiic/git-log.nvim',
--     event = {'BufReadPre','BufNewFile'},
--     dependencies = {'niuiic/core.nvim'},
--     keys = {
--         {'<leader>go', '<cmd>lua require("git-log").check_log()<cr>', noremap=true, silent=true, desc='Display the git log for the selected text'},
--     },
-- },

{
    'ragnarok22/whereami.nvim',
    cmd = "Whereami"
},

} -- end of return
