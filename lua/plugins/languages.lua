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
-- Treesitter
----------------------------------
{'nvim-treesitter/nvim-treesitter',
    event = {'BufReadPost', 'BufNewFile'},
    run = ':TSUpdate',
    opts =
    {
        ensure_installed =
        {
            'arduino','asm','awk','bash','bibtex','c','cmake','comment','commonlisp',
            'cpp','css','csv','cuda','desktop','diff','disassembly','dot','doxygen',
            'fortran','git_config','git_rebase','gitattributes','gitcommit','gitignore',
            'haskell','html','idl','ini','javascript','json','latex','llvm','lua','luadoc',
            'make','markdown','markdown_inline','nasm','ninja','passwd','po','printf',
            'properties','proto','python','query','r','readline','regex','rnoweb','robots',
            'rust','scheme','sql','ssh_config','strace','tmux','todotxt','udev','vim','vimdoc',
            'xml','yaml','zig'
        },
        auto_install = true,
        highlight =
        {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent =
        {
            enable = false,
        },
    },
    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
    end,
},

----------------------------------
-- LSP
----------------------------------
{'williamboman/mason.nvim',    -- Package manager to install LSP servers, linters, formatters and debuggers
    lazy = false,
    cmd = 'Mason',
    dependencies = {'williamboman/mason-lspconfig.nvim', -- Bridge between the previous and the next package :-)
        lazy = false,
        opts = {
            automatic_installation = true,
        },
        config = function(_,opts)
            require('mason-lspconfig').setup(opts)
        end,
    },
    config = function()
        require('mason').setup({})
    end,
},

{'neovim/nvim-lspconfig',   -- Configure and start language servers when appropriate
    dependencies = {'saghen/blink.cmp' },
    event = {'BufReadPre', 'BufNewFile', 'LspAttach'},
    keys = {
        {'<leader>ld', vim.lsp.buf.definition,
            mode='n', noremap=true, silent=true, desc="Jump to the symbol's definition under the cursor"},
        {'<leader>lh', vim.lsp.buf.hover,
            mode='n', noremap=true, silent=true, desc='Symbol help information'},
        {'<leader>li', vim.lsp.buf.implementation,
            mode='n', noremap=true, silent=true, desc='Symbol implementation'},
        {'<leader>ls', vim.lsp.buf.signature_help,
            mode='n', noremap=true, silent=true, desc='Symbol signature help'},
        {'<leader>lt', vim.lsp.buf.type_definition,
            mode='n', noremap=true, silent=true, desc='Symbol type definition'},
        {'<leader>lr', vim.lsp.buf.rename,
            mode='n', noremap=true, silent=true, desc='Rename symbol'},
        {'<leader>lf', vim.lsp.buf.formatting,
            mode='n', noremap=true, silent=true , desc='Format code'},
        {'<leader>le', '<cmd>ClangdTypeHierarchy<cr>',
            noremap=true, silent=true, desc='C++ type hierarchy (from clangd)'},
        {'<leader>ln', '<cmd>ClangdSymbolInfo<cr>',
            noremap=true, silent=true, desc='C++ symbol information (from clangd)'},
    },
    opts = {
        servers = {
            clangd = {
                cmd = {'clangd', '--clang-tidy', '-j=5', '--malloc-trim', '--offset-encoding=utf-16'},
            },
            r_language_server = { },
            bashls = {
                filetypes = {'zsh','bash','sh'},
            },
            neocmake = {},
            jsonls = {},
            texlab = {},
            lua_ls = {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {'vim'},
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file('', true),
                            checkThirdParty = false,
                        },
                    },
                },
            },
            pyright = {},
--          pylsp = {
--              plugins = {
--                  pycodestyle = {
--                      ignore = { 'E123', 'E127', 'E128', 'E201', 'E202', 'E203', 'E221', 'E222',
--                                  'E225', 'E226', 'E231', 'E251', 'E261', 'E262', 'E265', 'E301',
--                                  'E302', 'E305', 'E401', 'E402', 'E501', 'W191', 'W391',
--                      },
--                      maxLineLength = 100
--                  }
--              }
--          },
        },
    },
    config = function(_, opts)
        local lspconfig = require('lspconfig')
        for server, config in pairs(opts.servers) do
            config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
            lspconfig[server].setup(config)
        end
    end
},

{'stevearc/aerial.nvim',
    event = {'BufReadPre', 'BufNewFile', 'LspAttach'},
    opts = {},
    dependencies =
    {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons'
    },
    keys =
    {
        {'<leader>lo', '<cmd>AerialToggle<CR>',
          mode='n', noremap=true, silent=true, desc='Display a list of symbols'},
    },
},

{'onsails/lspkind.nvim',
    event='LspAttach',
},

{'Chaitanyabsprip/fastaction.nvim',
    opts = {},
    keys =
    {
        {'<leader>ca', '<cmd>lua require("fastaction").code_action()<CR>',
            mode='n', noremap=true, silent=true, desc='Use a code action at the cursor'},
        {'<leader>cr', '<cmd>lua require("fastaction").range_code_action()<CR>',
            mode='n', noremap=true, silent=true, desc='Use a code action to a selected range'},
    }
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
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts =
    {
        sources =
        {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            compat = { cmp_r = { name='cmp_r', module='blink.compat.source' }, },
        },
        keymap =
        {
            preset = 'enter',
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
        appearance = { nerd_font_variant = 'mono' },
        completion =
        {
            documentation = { auto_show = true },
            menu =
            {
                draw =
                {
                    padding = {0, 1},
                    columns = {{'item_idx'}, {'kind_icon'}, {'label'}, {'label_description', gap=1}},
                    components =
                    {
                        kind_icon = { text = function(ctx) return ' '.. ctx.kind_icon .. ctx.icon_gap .. ' ' end },
                        item_idx =
                        {
                            text = function(ctx) return ctx.idx==10 and '0' or ctx.idx>=10 and ' ' or tostring(ctx.idx) end,
                            highlight='BlinkCmpItemIdx',
                        }
                    }
                }
            }
        },
        fuzzy = { implementation = 'lua', sorts = {'exact','score','sort_text'}, }
    },
    opts_extend = { "sources.default" }
},

--{'hrsh7th/nvim-cmp',
--        {'hrsh7th/cmp-nvim-lua', },
--        {'amarakon/nvim-cmp-lua-latex-symbols', },
--
--  { name = 'nvim_lua', priority = 75 },
--  { name = 'lua-latex-symbols', option = { cache = true }, priority= 70 },
--  { name = 'nvim_lsp_document_symbol', priority = 30 },
--            mapping =
--            {
--                ['<Tab>'] = cmp.mapping.select_next_item(),
--                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
--                ['<C-Space>'] = cmp.mapping.complete(),
--                ['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Insert, select = false, }),
--            },

----------------------------------
-- Misc.
----------------------------------
{'aklt/plantuml-syntax', -- PlantUML syntax
    ft='plantuml',
}

} -- end of return
