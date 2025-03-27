local options = {
  strategies = {
    -- Change the default chat adapter
    chat = {
      adapter = "deepseek",
    },
    inline = {
      adapter = "deepseek",
    },
  },
  adapters = {
    deepseek = function()
      local function clean_streamed_data(data)
        if type(data) == "table" then
          return data.body
        end
        local find_json_start = string.find(data, "{") or 1
        return string.sub(data, find_json_start)
      end
      return require("codecompanion.adapters").extend("openai_compatible", {
        env = {
          url = "cmd:pass show bytedance/ark/base_url",
          api_key = "cmd:pass show bytedance/ark/api_key",
          chat_url = "/chat/completions",
        },
        handlers = {
          chat_output = function(self, data)
            local output = {}

            if data and data ~= "" then
              local data_mod = clean_streamed_data(data)
              local ok, json = pcall(vim.json.decode, data_mod, { luanil = { object = true } })

              if ok and json.choices and #json.choices > 0 then
                local choice = json.choices[1]
                local delta = (self.opts and self.opts.stream) and choice.delta or choice.message

                if delta then
                  if delta.role then
                    output.role = delta.role
                  else
                    output.role = nil
                  end

                  output.content = ""

                  -- ADD THINKING OUTPUT
                  if delta.reasoning_content then
                    output.content = delta.reasoning_content
                  end

                  if delta.content then
                    output.content = output.content .. delta.content
                  end

                  return {
                    status = "success",
                    output = output,
                  }
                end
              end
            end
          end,
        },
        schema = {
          model = {
            default = "ep-20250219105002-8vpw6", -- define llm model to be used
          },
          temperature = {
            order = 2,
            mapping = "parameters",
            type = "number",
            optional = true,
            default = 0.0,
            desc = "What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.",
            validate = function(n)
              return n >= 0 and n <= 2, "Must be between 0 and 2"
            end,
          },
        },
      })
    end,
  },
}

return options
