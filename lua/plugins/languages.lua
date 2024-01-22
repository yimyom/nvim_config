return {

{'simrat39/symbols-outline.nvim',
    keys = { {'<leader>lo', '<cmd>SymbolsOutline<cr>', mode='n', noremap=true, silent=true, desc='List of symbols in the sidebar'} }
},

'aklt/plantuml-syntax', -- PlantUML syntax

{'folke/trouble.nvim', dependencies = {'nvim-tree/nvim-web-devicons'},
    keys = {
        {'<leader>tx', '<cmd>lua require("trouble").open()<cr>', noremap=true, silent=true, desc='Open Trouble window'},
        {'<leader>tw', '<cmd>lua require("trouble").open("workspace_diagnostics")<cr>', noremap=true, silent=true, desc='Open workspace diagnostics window'},
        {'<leader>td', '<cmd>lua require("trouble").open("document_diagnostics")<cr>', noremap=true, silent=true, desc='Open document diagnostics window'},
        {'<leader>tq', '<cmd>lua require("trouble").open("quickfix")<cr>', noremap=true, silent=true, desc='Open QuickFix window'},
        {'<leader>tl', '<cmd>lua require("trouble").open("loclist")<cr>', noremap=true, silent=true, desc='Open location list'}, },
},

{'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {'arduino','awk','bash','bibtex','c','cmake',
            'cpp','css','csv','diff','dot','git_rebase','gitattributes',
            'gitcommit','html','javascript','json','latex','lua','make',
            'markdown','markdown_inline','ninja','python','r','regex','yaml'},
            auto_install = true,
            highlight = { enable = true, additional_vim_regex_highlighting = false, },
            indent = { enable = true }, })
        end
},

{'neovim/nvim-lspconfig',
    event = {'BufReadPre', 'BufNewFile', 'LspAttach'},
    keys = {
        {'<leader>ld', vim.lsp.buf.definition, noremap=true, silent=true, desc='Jump to the definition of the symbol under the cursor'},
        {'<leader>lh', vim.lsp.buf.hover,  mode='n', noremap=true, silent=true, desc='Symbol help information'},
        {'<leader>li', vim.lsp.buf.implementation,  mode='n', noremap=true, silent=true, desc='Symbol implementation'},
        {'<leader>ls', vim.lsp.buf.signature_help, mode='n', noremap=true, silent=true, desc='Symbol signature help'},
        {'<leader>lt', vim.lsp.buf.type_definition,  mode='n', noremap=true, silent=true, desc='Symbol type definition'},
        {'<leader>lr', vim.lsp.buf.rename,  mode='n', noremap=true, silent=true, desc='Rename symbol'},
        {'<leader>lf', vim.lsp.buf.formatting,  mode='n', noremap=true, silent=true , desc='Format code'},
        {'<leader>le', '<cmd>ClangdTypeHierarchy<cr>',  noremap=true, silent=true, desc='Type hierarchy'},
        {'<leader>ln', '<cmd>ClangdSymbolInfo<cr>', noremap=true, silent=true, desc='Symbol information'},
    },
    config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local on_attach = function(client, bufnr)
                    vim.g.completion_matching_strategy_list = "['exact', 'substring', 'fuzzy']"
                end
            require('lspconfig')['bashls'].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                filetypes = { 'zsh', 'bash', 'sh' },
            })
            require('lspconfig')['clangd'].setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    vim.g.completion_matching_strategy_list = "['exact', 'substring', 'fuzzy']"
                    require('clangd_extensions.inlay_hints').setup_autocmd()
                    require('clangd_extensions.inlay_hints').set_inlay_hints()
                end,
            })
            require('lspconfig')['r_language_server'].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            require('lspconfig')['pylsp'].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    pylsp = { plugins = { pycodestyle = {
                        ignore = {'E202','E123','E251','E128','E305','E301','E501','E302',
                            'W391','E401','E261','E221','E265','E225','E226','E201','E222',
                            'E231','E127','E203','E402','W191'},
                        maxLineLength = 100
                        }}}}})
            end
},

{'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-buffer',
--        'jalvesaq/cmp-nvim-r',
        {'saadparwaiz1/cmp_luasnip',
            dependencies = {
                {'L3MON4D3/LuaSnip',
                    version = '2.*',
                    build = 'make install_jsregexp',
                },},
        },},
    config = function()
        local cmp = require('cmp')
        cmp.setup({
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        mapping = {
           ['<Tab>'] = cmp.mapping.select_next_item(),
           ['<S-Tab>']=cmp.mapping.select_prev_item(),
           ['<C-Space>'] = cmp.mapping.complete(),
           ['<CR>'] = cmp.mapping.confirm({
               behavior = cmp.ConfirmBehavior.Insert,
               select = true, })
        },
        sources = {
            { name = 'path' },
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'nvim_lua' },
            { name = 'buffer' },
            { name = 'luasnip' },
            { name = 'cmp_nvim_r' }
        },
        formatting = {
            fields = {'menu', 'abbr', 'kind'},
            format = function(entry, item)
            local menu_icon ={
                nvim_lsp = 'λ',
                vsnip = '⋗',
                buffer = 'b',
                path = 'p'
            }
            item.menu = menu_icon[entry.source.name]
            return item
            end,
        } })
        end
},

{'p00f/clangd_extensions.nvim', -- Extra clang LSP features
    config = function()
        require('clangd_extensions').setup({
            inlay_hints = {
                },
            symbol_info = {
                border = {
                { "╭", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╮", "FloatBorder" },
                { "│", "FloatBorder" },
                { "╯", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╰", "FloatBorder" },
                { "│", "FloatBorder" }, }
                },
        })
        end,
--    opts = {
--        inlay_hints = {
--            show_parameter_hints = false,
--            right_align = true,
--            },
--        },
},

--{'nvimdev/lspsaga.nvim', -- More LSP features
--    event = 'LspAttach',
--    config = function()
--        require('lspsaga').setup({})
--    end,
--    dependencies = {'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons'},
--},

--'mfussenegger/nvim-dap',
--'rcarriga/nvim-dap-ui',
--'nvim-telescope/telescope-dap.nvim',
--'theHamsta/nvim-dap-virtual-text',

}
