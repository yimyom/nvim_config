-- This file is part of nvim_config.
-- nvim_config is free software: you can redistribute it and/or modify it under the terms of the
-- GNU General Public License as published by the Free Software Foundation, either version 3 of
-- the License, or (at your option) any later version. nvim_config is distributed in the hope 
-- that it will be useful, but WITHOUT ANY WARRANTY; with-ignout even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details. You should have received a copy of the GNU General Public License along with
-- nvim_config. If not, see <https://www.gnu.org/licenses/>.

-- CodeCompanion configuration --
local config_path = vim.fn.stdpath('data') .. '/codecompanion_api_keys.lua'

local supported_engines =
{
    { name = 'Anthropic',	    adapter = 'anthropic', },
	{ name = 'Augment Code',	adapter = 'auggie_cli', },
    { name = 'Cagent',	        adapter = 'cagent', },
	{ name = 'Claude Code',	    adapter = 'claude_code', },
	{ name = 'Codex',	        adapter = 'codex', },
	{ name = 'Copilot',	        adapter = 'copilot', },
	{ name = 'Gemini CLI',	    adapter = 'gemini_cli', },
	{ name = 'GitHub Models',   adapter = 'githubmodels', },
	{ name = 'Goose',	        adapter = 'goose', },
	{ name = 'DeepSeek',	    adapter = 'deepseek', },
	{ name = 'Gemini',	        adapter = 'gemini', },
	{ name = 'HuggingFace',	    adapter = 'huggingface', },
	{ name = 'Kimi CLI',	    adapter = 'kimi_cli', },
	{ name = 'Mistral AI',	    adapter = 'mistral', },
	{ name = 'Novita',	        adapter = 'novita', },
	{ name = 'Ollama',	        adapter = 'ollama', },
	{ name = 'OpenAI',	        adapter = 'openai', },
	{ name = 'opencode',	    adapter = 'opencode', },
	{ name = 'xAI',	            adapter = 'xai', },
    { name = 'Do not install an LLM engine', adapter = 'no_install', },
}

local function check_for_existing_config()
    -- try to open the file
    local file_handle = io.open(config_path, 'r')
    local exists = file_handle ~= nil
    if file_handle then -- it worked: just close it now
        file_handle:close()
    end

    local engine = nil
    if exists then -- we have a config file, load it
        local ok, result = pcall(dofile, config_path)
        if ok then
            engine = result
        else
            vim.notify('Invalid or corrupted LLM config file. Removing and recreating.', vim.log.levels.WARN)
            os.remove(config_path)
            exists = false
        end
    end

    return engine
end
   
local function make_codecompanion_cfg(engine)
    return
    {
        interactions =
        {
            chat = { adapter = engine.adapter, },
            inline = { adapter = engine.adapter, },
            cmd = { adapter = engine.adapter, },
            background = { adapter = engine.adapter, },
        },
        strategies =
        {
            chat = { adapter = engine.adapter },
            inline = { adapter = engine.adapter },
            agent = { adapter = engine.adapter },
        },
        opts = { log_level = 'DEBUG', },
    }
end

-- Save the engine configuration into a small lua file
local function save_table(filename, tbl)
    local file = io.open(filename, 'w')
    if file then
        file:write('-- File automatically generated. Do not edit\nreturn\n{\n')
        for k, v in pairs(tbl) do
            local val = type(v) == 'string' and string.format('%q', v) or tostring(v)
            file:write(string.format('  %s = %s,\n', k, val))
        end
        file:write('}\n')
        file:close()
    end
end

return {

----------------------------------
-- LLM
----------------------------------
{'olimorris/codecompanion.nvim',
    dependencies =
    {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    -- Lazy-load on any of the plugin's commands
    cmd =
    {
        "CodeCompanion",
        "CodeCompanionChat",
        "CodeCompanionCmd",
        "CodeCompanionActions",
    },
    config =
        function(_, _opts)
            local engine = check_for_existing_config()
            if not engine then -- engine was nil, ask the user
                vim.ui.select(
                    supported_engines, 
                    {
                        prompt = 'Choose an LLM engine:',
                        format_item = function(item) return item.name end,
                    },
                    function(choice,_)
                        if choice then
                            save_table(config_path, choice)
                            local opts = make_codecompanion_cfg(choice)
                            require('codecompanion').setup(opts)
                        end
                    end
                )
            else
                if engine.adapter ~= 'no_install' then
                    local opts = make_codecompanion_cfg(engine)
                    require('codecompanion').setup(opts)
                end
            end
        end,
}

} -- end of return
