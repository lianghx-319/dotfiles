local role_map = {
  user = "human",
  assistant = "assistant",
  system = "system",
}

local parse_messages = function(opts)
  local messages = {
    { role = "system", content = opts.system_prompt },
  }
  vim.iter(opts.messages):each(function(msg)
    table.insert(messages, { speaker = role_map[msg.role], text = msg.content })
  end)
  return messages
end

local parse_response = function(data_stream, event_state, opts)
  if event_state == "done" then
    opts.on_complete()
    return
  end

  if data_stream == nil or data_stream == "" then
    return
  end

  local json = vim.json.decode(data_stream)
  local delta = json.deltaText
  local stopReason = json.stopReason

  if stopReason == "end_turn" then
    return
  end

  opts.on_chunk(delta)
end

return {
  ollama = {
    __inherited_from = "openai",
    api_key_name = "",
    endpoint = "http://127.0.0.1:11434/v1",
    model = "deepseek-r1:7b",
    disable_tools = true,
  },
  ark = {
    endpoint = "https://ark-cn-beijing.bytedance.net/api/v3/chat/completions",
    model = "ep-20250206204944-qlqg4",
    api_key_name = "ARK_API_KEY",
    --- This function below will be used to parse in cURL arguments.
    --- It takes in the provider options as the first argument, followed by code_opts retrieved from given buffer.
    --- This code_opts include:
    --- - question: Input from the users
    --- - code_lang: the language of given code buffer
    --- - code_content: content of code buffer
    --- - selected_code_content: (optional) If given code content is selected in visual mode as context.
    ---@type fun(opts: AvanteProvider, code_opts: AvantePromptOptions): AvanteCurlOutput
    parse_curl_args = function(opts, code_opts)
      local headers = {
        ["Content-Type"] = "application/json",
        ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
      }

      return {
        url = opts.endpoint,
        timeout = base.timeout,
        insecure = false,
        headers = headers,
        body = vim.tbl_deep_extend("force", {
          model = opts.model,
          temperature = 0,
          topK = -1,
          topP = -1,
          maxTokensToSample = 4000,
          stream = true,
          messages = M.parse_messages(code_opts),
        }, {}),
      }
    end,
    parse_response = parse_response,
    parse_messages = parse_messages,
  },
}
