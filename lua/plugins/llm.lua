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
    { name = 'Anthropic',	    adapter = 'anthropic',    needs_key=true,  needs_url = false },
	{ name = 'Augment Code',	adapter = 'auggie_cli',   needs_key=true,  needs_url = false },
    { name = 'Cagent',	        adapter = 'cagent',       needs_key=false, needs_url = false },
	{ name = 'Claude Code',	    adapter = 'claude_code',  needs_key=true,  needs_url = false },
	{ name = 'Codex',	        adapter = 'codex',        needs_key=true,  needs_url = false },
	{ name = 'Copilot',	        adapter = 'copilot',      needs_key=true,  needs_url = false },
	{ name = 'Gemini CLI',	    adapter = 'gemini_cli',   needs_key=true,  needs_url = false },
	{ name = 'GitHub Models',   adapter = 'githubmodels', needs_key=false, needs_url = false },
	{ name = 'Goose',	        adapter = 'goose',        needs_key=true,  needs_url = false },
	{ name = 'DeepSeek',	    adapter = 'deepseek',     needs_key=true,  needs_url = false },
	{ name = 'Gemini',	        adapter = 'gemini',       needs_key=true,  needs_url = false },
	{ name = 'HuggingFace',	    adapter = 'huggingface',  needs_key=true,  needs_url = false },
	{ name = 'Kimi CLI',	    adapter = 'kimi_cli',     needs_key=true,  needs_url = false },
	{ name = 'Mistral AI',	    adapter = 'mistral',      needs_key=true,  needs_url = false },
	{ name = 'Novita',	        adapter = 'novita',       needs_key=true,  needs_url = false },
	{ name = 'Ollama',	        adapter = 'ollama',       needs_key=false, needs_url = true  },
	{ name = 'OpenAI',	        adapter = 'openai',       needs_key=true,  needs_url = false },
	{ name = 'opencode',	    adapter = 'opencode',     needs_key=true,  needs_url = false },
	{ name = 'xAI',	            adapter = 'xai',          needs_key=true,  needs_url = false },
    { name = 'Do not install LLM engine', adapter = 'no_install',   needs_key=false, needs_url = false },
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
    local opts =
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
        adapters =
        {
            http = {}
        },
        opts = { log_level = 'ERROR', },
    }
    opts.adapters.http[engine.adapter] = function()
        return require('codecompanion.adapters').extend(engine.adapter,
        {
            env =
            {
                api_key = engine.api_key,
            },
        })
    end

    return opts
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

local function save_and_configure(choice)
    -- After all inputs are collected, save and setup
    save_table(config_path, choice)
    require('codecompanion').setup(make_codecompanion_cfg(choice))
end
 
local function engine_choice(choice,_)
    if choice then
        if choice.needs_key and choice.needs_url then
            vim.ui.input({ prompt = 'Enter ' .. choice.name .. ' API key:' }, function(key)
                if not key then return end
                choice.api_key = key
                vim.ui.input({ prompt = 'Enter ' .. choice.name .. ' URL:' }, function(url)
                    if not url then return end
                    choice.url = url
                    save_and_configure(choice)
                end)
            end)
        elseif choice.needs_key then
            vim.ui.input({ prompt = 'Enter ' .. choice.name .. ' API key:' }, function(key)
                if not key then return end
                choice.api_key = key
                save_and_configure(choice)
            end)
        elseif choice.needs_url then
            vim.ui.input({ prompt = 'Enter ' .. choice.name .. ' URL:' }, function(url)
                if not url then return end
                choice.url = url
                save_and_configure(choice)
            end)
        else
            -- No extra input needed
            save_and_configure(choice)
        end
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
             -- engine was nil, ask the user
            if not engine then
                vim.ui.select(supported_engines, 
                                {
                                    prompt = 'Choose an LLM engine:',
                                    format_item = function(item) return item.name end,
                                },
                                engine_choice
                            )
            else
                if engine.adapter ~= 'no_install' then
                    require('codecompanion').setup(make_codecompanion_cfg(engine))
                end
            end
        end
}

} -- end of return
