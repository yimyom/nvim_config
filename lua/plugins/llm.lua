-- This file is part of nvim_config.
-- nvim_config is free software: you can redistribute it and/or modify it under the terms of the
-- GNU General Public License as published by the Free Software Foundation, either version 3 of
-- the License, or (at your option) any later version. nvim_config is distributed in the hope 
-- that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details. You should have received a copy of the GNU General Public License along with
-- nvim_config. If not, see <https://www.gnu.org/licenses/>.

return {

{'olimorris/codecompanion.nvim',
    lazy = false,
    opts =
    {
        strategies =
        {
            chat   = { adapter = 'deepseek' },
            inline = { adapter = 'deepseek' },
            cmd    = { adapter = 'deepseek' },
        },
        adapters =
        {
           anthropic = function()
                return require("codecompanion.adapters").extend("anthropic",
                    { env = { api_key = os.getenv('ANTHROPIC_API_KEY'), }, })
                end,
            deepseek = function()
                return require('codecompanion.adapters').extend('deepseek',
                    {env = { api_key = os.getenv("DEEPSEEK_API_KEY") }, })
                end,
--            gemini = function()
--                return require('codecompanion.adapters').extend('gemini',
--                    {env = { api_key = 'GEMINI_API_KEY' }, })
--                end,
--            mistral = function()
--                return require('codecompanion.adapters').extend('mistral',
--                    {env = { api_key = 'MISTRAL_API_KEY' }, })
--                end,
--            ollama = function()
--                return require('codecompanion.adapters').extend('ollama',
--                    { schema = { model = { default = 'llama3.1:latest', },
--                                 num_ctx = { default = 20000,}, }, })
--                end,
--            openai = function()
--                return require('codecompanion.adapters').extend('openai',
--                    {
--                        opts = { stream = true, },
--                        env = { api_key = 'OPENAI_API_KEY', },
--                        schema = { model = { default = function() return 'gpt-4.1' end, }, },
--                    })
--                end,
--            xai = function()
--                return require('codecompanion.adapters').extend('xai',
--                    {env = { api_key = 'XAI_API_KEY' }, })
--                end,
        },
    },
},

--{'yetone/avante.nvim',
--    event = 'VeryLazy',
--    version = false,
--    build = 'make',                         -- build from source
--    opts =
--    {
--        provider = 'deepseek',                  -- or 'deepseek', 'copilot', 'ollama', 'aihubmix'
--        vendors =
--        {
--            deepseek =
--            {
--                __inherited_from = 'openai',
--                api_key_name = '',
--                endpoint = 'https://api.deepseek.com',
--                model = 'deepseek-coder',
--                max_tokens = 8192,
--            },
--          },
--    },
--},

} -- end of return
