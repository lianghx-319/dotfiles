local map = vim.keymap.set

-- Get project root directory
local function get_project_root()
  local current_file = vim.fn.expand("%:p")
  local current_dir = vim.fn.fnamemodify(current_file, ":h")

  -- Find .git or package.json upwards
  local root_patterns = { ".git", "package.json" }
  local root = vim.fs.find(root_patterns, {
    path = current_dir,
    upward = true,
    stop = vim.loop.os_homedir(),
    type = "directory",
  })[1]

  if root then
    if vim.fn.isdirectory(root) == 1 then
      -- If it's a directory (.git), return its parent
      return vim.fn.fnamemodify(root, ":h")
    else
      -- If it's a file (package.json), return its directory
      return vim.fn.fnamemodify(root, ":h")
    end
  end

  -- Fallback to current buffer's directory
  return current_dir
end

-- Get formatter config file path
local function get_formatter_config_path()
  return vim.fn.stdpath "config" .. "/formatter-config.json"
end

-- Load formatter from config file
local function load_formatter()
  local config_path = get_formatter_config_path()
  local success, file = pcall(io.open, config_path, "r")
  if success and file then
    local content = file:read "*all"
    file:close()
    if content then
      local ok, config = pcall(vim.fn.json_decode, content)
      if ok and config then
        local root = get_project_root()
        return config[root] or "prettier"
      end
    end
  end
  return "prettier"
end

-- Save formatter to config file
local function save_formatter(fmt)
  local config_path = get_formatter_config_path()
  local root = get_project_root()

  -- Load existing config
  local config = {}
  local success, file = pcall(io.open, config_path, "r")
  if success and file then
    local content = file:read "*all"
    file:close()
    if content then
      local ok, loaded_config = pcall(vim.fn.json_decode, content)
      if ok and loaded_config then
        config = loaded_config
      end
    end
  end

  -- Update config
  config[root] = fmt

  -- Save updated config
  local success, file = pcall(io.open, config_path, "w")
  if success and file then
    local content = vim.fn.json_encode(config)
    file:write(content)
    file:close()
  end
end

local toggle = function()
  local current_formatter = load_formatter()
  local new_formatter = current_formatter == "prettier" and "eslint_d" or "prettier"
  save_formatter(new_formatter)
  vim.notify("Formatter switched to: " .. new_formatter, vim.log.levels.INFO)
end

map("n", "<leader>fx", toggle, { desc = "Toggle Formatter for JS" })

local format = function()
  return { load_formatter() }
end

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    typescript = format,
    typescriptreact = format,
    javascript = format,
    javascriptreact = format,
    sh = { "beautysh" },
    rust = { "rustfmt" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 5000,
    lsp_format = "never",
    stop_after_first = true,
  },
}

require("conform").setup(options)
