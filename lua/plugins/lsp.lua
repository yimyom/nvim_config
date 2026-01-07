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
-- LSP
----------------------------------
{'neovim/nvim-lspconfig',   -- Configure and start language servers when appropriate
    dependencies = {'saghen/blink.cmp' },
    event = {'BufReadPre', 'BufNewFile', 'LspAttach'},
    keys = 
    {
        {'<leader>ld', vim.lsp.buf.definition, mode='n', noremap=true, silent=true, desc="Jump to the symbol's definition under the cursor"},
        {'<leader>lh', vim.lsp.buf.hover, mode='n', noremap=true, silent=true, desc='Symbol help information'},
        {'<leader>li', vim.lsp.buf.implementation, mode='n', noremap=true, silent=true, desc='Symbol implementation'},
        {'<leader>ls', vim.lsp.buf.signature_help, mode='n', noremap=true, silent=true, desc='Symbol signature help'},
        {'<leader>lt', vim.lsp.buf.type_definition, mode='n', noremap=true, silent=true, desc='Symbol type definition'},
        {'<leader>lr', vim.lsp.buf.rename, mode='n', noremap=true, silent=true, desc='Rename symbol'},
        {'<leader>lf', vim.lsp.buf.formatting, mode='n', noremap=true, silent=true , desc='Format code'},
        {'<leader>le', '<cmd>ClangdTypeHierarchy<cr>', noremap=true, silent=true, desc='C++ type hierarchy (from clangd)'},
        {'<leader>ln', '<cmd>ClangdSymbolInfo<cr>', noremap=true, silent=true, desc='C++ symbol information (from clangd)'},
    },
    opts =
    {
        servers =
        {
            clangd = { cmd = {'clangd', '--clang-tidy', '-j=5', '--malloc-trim', '--offset-encoding=utf-16'}, },
            r_language_server = { },
            bashls = { filetypes = {'zsh','bash','sh'}, },
            neocmake = {},
            jsonls = {},
            texlab = {},
            lua_ls =
            {
                settings =
                {
                    Lua =
                    {
                        diagnostics = { globals = {'vim'}, },
                        workspace = { library = vim.api.nvim_get_runtime_file('', true), checkThirdParty = false, },
                    },
                },
            },
            pyright =
            {
                settings =
                {
                    pyright =
                    {
                        disableLanguageServices = false,
                        disableOrganizeImports = false,
                    },
                    python =
                    {
                        analysis =
                        {
                            typeCheckingMode = 'strict', -- off, basic, strict
                            diagnosticMode = 'workspace', -- openFilesOnly, workspace
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            autoImportCompletions = true,
                        }
                    }
                }
            },
        },
    },

    config = function(_, opts)
        -- Apply enhanced capabilities globally (blink.cmp does this automatically on 0.11+,
        -- but calling it explicitly ensures it's ready early if needed)
        vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities(), })

        -- Override/extend specific server configs with my custom settings
        for server, server_opts in pairs(opts.servers) do
            vim.lsp.config(server, server_opts)
        end

        -- Enable all the servers (they'll use nvim-lspconfig defaults + my overrides)
        local servers_to_enable = vim.tbl_keys(opts.servers)
        vim.lsp.enable(servers_to_enable)
    end,
},

{'mason-org/mason.nvim',
    cmd = 'Mason',
    opts =
    {
        ui =
        {
            icons =
            {
                package_installed = '✓',
                package_pending = '➜',
                package_uninstalled = '✗'
            }
        }
    }
}

} -- end of return
