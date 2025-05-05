-- This file is part of nvim_config.
-- nvim_config is free software: you can redistribute it and/or modify it under the terms of the
-- GNU General Public License as published by the Free Software Foundation, either version 3 of
-- the License, or (at your option) any later version. nvim_config is distributed in the hope 
-- that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details. You should have received a copy of the GNU General Public License along with
-- nvim_config. If not, see <https://www.gnu.org/licenses/>.

return {

--{'olimorris/codecompanion.nvim',
--    opts =
--    {
--        adapters =
--        {
--            deepseek = function()
--                return require('codecompanion.adapters').extend('deepseek',{env = { api_key = 'YOUR_DEEPSEEK_API_KEY' }, })
--                end,
--        },
--        strategies =
--        {
--            chat   = { adapter = 'deepseek' },
--            inline = { adapter = 'deepseek' },
--            agent  = { adapter = 'deepseek' },
--        },
--    },
--},

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
