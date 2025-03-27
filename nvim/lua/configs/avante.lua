return {
  siliconflow = {
    __inherited_from = "openai",
    endpoint = "https://api.siliconflow.cn/v1",
    -- model = "Qwen/Qwen2.5-32B-Instruct",
    model = "Qwen/Qwen2.5-72B-Instruct-128K",
    api_key_name = "SILICONFLOW_API_KEY",
  },
  ollama = {
    __inherited_from = "openai",
    api_key_name = "",
    endpoint = "http://127.0.0.1:11434/v1",
    model = "deepseek-r1:7b",
    disable_tools = true,
  },
  ark = {
    disable_tools = true,
    __inherited_from = "openai",
    endpoint = "https://ark-cn-beijing.bytedance.net/api/v3",
    model = "ep-20250207120339-pzr7h",
    api_key_name = "ARK_API_KEY",
  },
}
