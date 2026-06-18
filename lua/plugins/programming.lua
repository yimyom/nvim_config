-- This file is part of nvim_config.
-- nvim_config is free software: you can redistribute it and/or modify it under the terms of the
-- GNU General Public License as published by the Free Software Foundation, either version 3 of
-- the License, or (at your option) any later version. nvim_config is distributed in the hope 
-- that it will be useful, but WITHOUT ANY WARRANTY; with-ignout even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details. You should have received a copy of the GNU General Public License along with
-- nvim_config. If not, see <https://www.gnu.org/licenses/>.

return {

----------------------------------
-- List of symbols
----------------------------------
{'hedyhli/outline.nvim',
    cmd = { "Outline", "OutlineOpen" },
    event = {'LspAttach'},
    keys =
    {
        {'<leader>lo', '<cmd>Outline<CR>', mode='n', noremap=true, silent=true, desc = 'List symbols'},
    },
    config = function(_, opts)
        require('outline').setup(opts)
    end,
},

----------------------------------
-- Treesitter
----------------------------------
{'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    init = function()
        local ts = require('nvim-treesitter')
        local langs = { 'arduino','asm','awk','bash','bibtex','c','cmake','comment','commonlisp',
                'cpp','css','csv','cuda','desktop','diff','disassembly','dot','doxygen',
                'git_config','git_rebase','gitattributes','gitcommit','gitignore',
                'haskell','html','idl','ini','javascript','json','lua','luadoc',
                'make','markdown','markdown_inline','ninja','passwd','po','printf',
                'properties','proto','python','query','r','readline','regex',
                'rust','scheme','sql','ssh_config','strace','tmux','todotxt','udev','vim',
                'xml','yaml'}
        local installed = ts.get_installed()
        local missing = vim.iter(langs)
            :filter(function(p) return not vim.tbl_contains(installed, p) end)
            :totable()

        if #missing > 0 then
            ts.install(missing)
        end

        local group = vim.api.nvim_create_augroup('TreesitterGroup', {clear = true})
        vim.api.nvim_create_autocmd('FileType',
        {
            group = group,
            pattern = langs,
            callback = function(args)
                local buf = args.buf
                vim.treesitter.start(buf)
                vim.bo[buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
                vim.opt_local.foldmethod = 'expr'
                vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                vim.opt_local.foldlevel = 99
                vim.opt_local.foldtext= [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
            end,
        })
    end,
},

----------------------------------
-- C++
----------------------------------
{'p00f/clangd_extensions.nvim', -- Extra clang LSP features
    lazy = true,
    ft = {'c', 'cpp', 'objc', 'objcpp'},
    opts =
    {
        inlay_hints =
        {
            auto = true,
            only_current_line = true,
            show_parameter_hints = true,
            parameter_hints_prefix = '← ',
            other_hints_prefix = '⇒ ',
            right_align = false,
        },
    },
},

----------------------------------
-- R
----------------------------------
{'R-nvim/cmp-r',
},

----------------------------------
-- Completion
----------------------------------
{'saghen/blink.cmp',
    event='InsertEnter',
    dependencies =
    {
        'saghen/blink.lib',
        'saghen/blink.compat',
        'onsails/lspkind.nvim',
        'R-nvim/cmp-r',
    },
    build = function()
        require('blink.cmp').build():pwait()
    end,

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts =
    {
        completion =
        {
            list = { selection = { preselect = false, auto_insert = true }, },
            accept = { auto_brackets = { enabled = false }, },
            documentation =
            {
                auto_show = true,
                auto_show_delay_ms = 250,
                treesitter_highlighting = true,
            },
            ghost_text = { enabled = true },
        },
        sources =
        {
            default = {'lsp', 'buffer', 'path', 'cmp_r'},
            providers =
            {
                cmp_r =
                {
                    name='cmp_r',
                    module = 'blink.compat.source',
                },
            },
        },
        fuzzy = { implementation = 'rust' },
        keymap =
        {
            preset = 'default',
            -- Select elements with Up, Down, Tab or Shift-Tab
            ['<Up>'] = { 'select_prev', 'fallback' },
            ['<Down>'] = { 'select_next', 'fallback' },
            ['<Tab>'] = { 'select_next', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
            -- Accept element with Return
            ['<CR>'] = { 'accept', 'fallback' },
            -- Show documentation with Ctrl-Space. Ctrl-b or f to move in long documentations
            ['<C-Space>'] = { 'show_documentation', 'hide_documentation' },
            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
            -- Use Alt-1 to 0 to directly accept an element
            ['<A-1>'] = { function(cmp) cmp.accept({ index = 1 }) end },
            ['<A-2>'] = { function(cmp) cmp.accept({ index = 2 }) end },
            ['<A-3>'] = { function(cmp) cmp.accept({ index = 3 }) end },
            ['<A-4>'] = { function(cmp) cmp.accept({ index = 4 }) end },
            ['<A-5>'] = { function(cmp) cmp.accept({ index = 5 }) end },
            ['<A-6>'] = { function(cmp) cmp.accept({ index = 6 }) end },
            ['<A-7>'] = { function(cmp) cmp.accept({ index = 7 }) end },
            ['<A-8>'] = { function(cmp) cmp.accept({ index = 8 }) end },
            ['<A-9>'] = { function(cmp) cmp.accept({ index = 9 }) end },
            ['<A-0>'] = { function(cmp) cmp.accept({ index = 10 }) end },
        },
        signature = { enabled = true, window = { show_documentation = true }},
        snippets = { preset = 'default' },
    },
},

----------------------------------
-- Misc.
----------------------------------
{'aklt/plantuml-syntax', -- PlantUML syntax
    ft='plantuml',
}

} -- end of return
