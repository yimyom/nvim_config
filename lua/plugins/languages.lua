-- This file is part of nvim_config.
-- nvim_config is free software: you can redistribute it and/or modify it under the terms of the
-- GNU General Public License as published by the Free Software Foundation, either version 3 of
-- the License, or (at your option) any later version. nvim_config is distributed in the hope 
-- that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details. You should have received a copy of the GNU General Public License along with
-- nvim_config. If not, see <https://www.gnu.org/licenses/>.

return {

{'aklt/plantuml-syntax', -- PlantUML syntax
    ft='plantuml',
},

{'nvim-treesitter/nvim-treesitter',
    event = {'BufReadPost', 'BufNewFile'},
    build = function()
        vim.cmd('TSUpdate')
    end,
    opts = {
        ensure_installed = {
            'arduino','awk','bash','bibtex','c','cmake',
            'cpp','css','csv','diff','dot','git_rebase','gitattributes',
            'gitcommit','html','javascript','json','latex','lua', 'make',
            'markdown','markdown_inline','ninja','python','r','regex','yaml',
        },
        auto_install = true,
        highlight = {
            enable = true,
            -- additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
        },
    },
    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
    end,
},

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
    event = {'BufReadPre', 'BufNewFile', 'LspAttach'},
    keys = {
        {'<leader>ld', vim.lsp.buf.definition,
            noremap=true, silent=true, desc='Jump to the definition of the symbol under the cursor'},
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
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        local on_attach = function(client, bufnr)
            vim.g.completion_matching_strategy_list = "['exact','substring','fuzzy']"
        end

        -- Configure each server individually
        for server,server_config in pairs(opts.servers) do
            server_config['capabilities'] = capabilities
            lspconfig[server].setup(server_config)
        end
    end,
},

{'onsails/lspkind.nvim',
    event='LspAttach',
},

{'hrsh7th/nvim-cmp',
    event='InsertEnter',
    dependencies = {
        {'hrsh7th/cmp-nvim-lsp', },
        {'hrsh7th/cmp-nvim-lsp-signature-help', },
--        {'ray-x/cmp-treesitter', },
        {'hrsh7th/cmp-buffer', },
        {'hrsh7th/cmp-path', },
--        {'bydlw98/cmp-env', },

        -- Lua completion
--        {'saadparwaiz1/cmp_luasnip'},
--        { 'hrsh7th/cmp-nvim-lua', },
        -- LaTeX completion
--        {'amarakon/nvim-cmp-lua-latex-symbols',
--            opts = { cache = true },
--        },
        -- Snippets
--        {'L3MON4D3/LuaSnip'},
        -- R completion
--        {'R-nvim/cmp-r',}
----        'jalvesaq/cmp-nvim-r',
    },
    -- We cannot use opts directly because this plugin needs to refer to
    -- itself during configuration 
    config = function() 
        local cmp = require('cmp')
        local cmp_buffer = require('cmp_buffer')
        local lspkind = require('lspkind')

        cmp.setup({
            sources = {
                { name = 'nvim_lsp' },
                { name = 'nvim_lsp_signature_help'},
--                { name = 'treesitter' },
                { name = 'buffer',
                    option = {
                        -- fct to index only in visible buffers if their size does not
                        -- exceed 2 Mb
                        get_bufnrs = function()
                            local bufs = {}
                            for _, win in ipairs(vim.api.nvim_list_wins()) do
                                local buf = vim.api.nvim_win_get_buf(win)
                                local bytes = vim.api.nvim_buf_get_offset(buf,
                                    vim.api.nvim_buf_line_count(buf))
                                if bytes > 2*1024*1024 then-- 2 megabytes max
                                    bufs[buf] = true
                                end
                            end
                            return vim.tbl_keys(bufs)
                        end
                    },
                },
                { name = 'path' },
--                { name = 'env',
--                    option = {
--                        eval_on_confirm = false,
--                        show_documentation_window = true,
--                        },
--                },
--                { name = 'lua-latex-symbol',
--                    options = { cache = true },
--                },
--                { name = 'nvim_lua' },
            },
            completion = {
                completeopt = 'menu,menuone,noselect,popup,noinsert',
            },
            window = {
                completion = {
                    border = 'rounded',
                },
                documentation = {
                    border = 'rounded',
                },
            },
            sorting = {
                comparators = {
                    function(...)
                        return cmp_buffer:compare_locality(...)
                    end,
                }
            },
            mapping = {
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<S-Tab>']=require('cmp').mapping.select_prev_item(),
                ['<C-Space>'] = require('cmp').mapping.complete(),
                ['<CR>'] = require('cmp').mapping.confirm({
                    behavior = require('cmp').ConfirmBehavior.Insert,
                    select = true,
                })
            },
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                    ellipsis_char = '...',
                    show_labelDetails = true,
                }),
            },
        })
    end,
},

-- {'p00f/clangd_extensions.nvim', -- Extra clang LSP features
--    lazy = false,
--    ft = {'c', 'cpp', 'objc', 'objcpp'},
--    opts = {
--        inlay_hints = {
--            parameter_hints_prefix = '← ',
--            other_hints_prefix = '⇒ ',
--        },
--    config = function(_,opts)
--        require('clangd_extensions').setup(opts)
--    end,
--    },
-- },

-- {'nvimdev/lspsaga.nvim',
--     event = 'LspAttach',
--     opts = {
--         ui = {
--             border = 'rounded',
--         },
--         outline = {
--             layout = 'float',
--         },
--     },
-- },

}
