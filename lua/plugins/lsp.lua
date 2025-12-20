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
        for server,cfg in pairs(opts.servers) do
            cfg.capabilities = require('blink.cmp').get_lsp_capabilities(cfg.capabilities)
            vim.lsp.config(server, cfg)
            vim.lsp.enable(server)
        end
    end
},

{
    'mason-org/mason.nvim',
    cmd = 'Mason',
    opts = {}
}

} -- end of return
