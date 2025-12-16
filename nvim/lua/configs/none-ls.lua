local none_ls = require "null-ls"
local u = require "null-ls.utils"

-- 检测项目是否使用 eslint
local function has_eslint_config()
  -- 检查常见的 eslint 配置文件
  local eslint_configs = {
    ".eslintrc.js",
    ".eslintrc.cjs", 
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
    ".eslintrc",
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs"
  }
  
  -- 检查 package.json 中是否有 eslint 配置
  local function has_eslint_in_package_json()
    local package_json = vim.fn.getcwd() .. "/package.json"
    if vim.fn.filereadable(package_json) == 1 then
      local content = vim.fn.readfile(package_json)
      local json_str = table.concat(content, "\n")
      return json_str:match('"eslint"') ~= nil
    end
    return false
  end
  
  -- 检查配置文件是否存在
  for _, config in ipairs(eslint_configs) do
    if u.path.exists(config) then
      return true
    end
  end
  
  return has_eslint_in_package_json()
end

local sources = {}

-- 只有在检测到 eslint 配置时才添加相关源
if has_eslint_config() then
  table.insert(sources, require "none-ls.code_actions.eslint_d")
  table.insert(sources, require "none-ls.diagnostics.eslint_d")
end

local options = {
  diagnostics_format = "[#{c}] #{m} (#{s})",
  sources = sources,
}

none_ls.setup(options)
