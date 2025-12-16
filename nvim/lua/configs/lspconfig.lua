local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- 保留 lspsaga 的快捷键，不做改动
local function lspsaga_key_mappings(buffer)
  local map = vim.keymap.set
  map("n", "gh", "<cmd>Lspsaga finder<cr>", { desc = "Lspsaga finder", buffer = buffer })
  map({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<cr>", { desc = "Lspsaga code action", buffer = buffer })
  map("n", "gr", "<cmd>Lspsaga rename<cr>", { desc = "Lspsaga rename", buffer = buffer })
  map("n", "gp", "<cmd>Lspsaga peek_definition<cr>", { desc = "Lspsaga peek definition", buffer = buffer })
  map("n", "gd", "<cmd>Lspsaga goto_definition<cr>", { desc = "Lspsaga goto definition", buffer = buffer })
  map("n", "gt", "<cmd>Lspsaga peek_type_definition<cr>", { desc = "Lspsaga peek type definition", buffer = buffer })
  map("n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Lspsaga hover doc", buffer = buffer })
  map("n", "<leader>o", "<cmd>Lspsaga outline<cr>", { desc = "Lspsaga outline", buffer = buffer })
  map("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<cr>", { desc = "Lspsaga incoming calls", buffer = buffer })
  map("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<cr>", { desc = "Lspsaga outgoing calls", buffer = buffer })
  map("n", "[e", function()
    require("lspsaga.diagnostic"):goto_prev { severity = vim.diagnostic.severity.ERROR }
  end, { desc = "Lspsaga goto prev diagnostic", buffer = buffer })
  map("n", "]e", function()
    require("lspsaga.diagnostic"):goto_next { severity = vim.diagnostic.severity.ERROR }
  end, { desc = "Lspsaga goto next diagnostics", buffer = buffer })
  map("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<cr>", { desc = "Lspsaga show line diagnostics", buffer = buffer })
  map("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<cr>", { desc = "Lspsaga show workspace diagnostics", buffer = buffer })
  map("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<cr>", { desc = "Lspsaga show cursor diagnostics", buffer = buffer })
end

local function custom_on_attach(client, buffer)
  on_attach(client, buffer)
  lspsaga_key_mappings(buffer)
end

-- 通用工具：查找可执行路径（按候选名）
local function exepath_for(candidates)
  for _, bin in ipairs(candidates) do
    local p = vim.fn.exepath(bin)
    if p and p ~= "" then return bin end
  end
  return nil
end

-- 通用工具：向上查找项目根目录
local function find_root(fname, names)
  local dir = vim.fs.dirname(fname)
  local found = vim.fs.find(names or { ".git" }, { path = dir, upward = true })[1]
  if found then return vim.fs.dirname(found) end
  return vim.fn.getcwd()
end

-- 统一用 vim.lsp.start 启动，不依赖 nvim-lspconfig 的 setup 框架
local function setup_server(name, spec)
  spec = spec or {}
  local bin = exepath_for(spec.candidates or { name })
  if not bin then
    -- 二进制未找到则不启动该服务
    return
  end
  local cmd = { bin }
  if spec.args then
    for _, a in ipairs(spec.args) do table.insert(cmd, a) end
  end

  local filetypes = spec.filetypes or { name }
  vim.api.nvim_create_autocmd("FileType", {
    pattern = filetypes,
    desc = "Start LSP: " .. name,
    callback = function(args)
      local fname = vim.api.nvim_buf_get_name(args.buf)
      local root_dir = find_root(fname, spec.root_patterns)
      local final = {
        name = name,
        cmd = cmd,
        root_dir = root_dir,
        settings = spec.settings,
        init_options = spec.init_options,
        capabilities = capabilities,
        on_init = on_init,
        on_attach = function(client, bufnr)
          custom_on_attach(client, bufnr)
        end,
      }
      vim.lsp.start(final)
    end,
  })
end

-- 常规服务器
setup_server("html", {
  candidates = { "vscode-html-language-server", "html-languageserver", "html-lsp" },
  args = { "--stdio" },
  filetypes = { "html" },
  root_patterns = { "package.json", ".git" },
})

setup_server("cssls", {
  candidates = { "vscode-css-language-server", "css-languageserver" },
  args = { "--stdio" },
  filetypes = { "css", "scss", "less" },
  root_patterns = { "package.json", ".git" },
})

setup_server("ts_ls", {
  candidates = { "typescript-language-server" },
  args = { "--stdio" },
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
  root_patterns = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
})

setup_server("tailwindcss", {
  candidates = { "tailwindcss-language-server" },
  args = { "--stdio" },
  filetypes = { "html", "css", "scss", "sass", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte", "vue" },
  root_patterns = { "tailwind.config.js", "tailwind.config.ts", "tailwind.config.cjs", "package.json", ".git" },
})

setup_server("taplo", {
  candidates = { "taplo" },
  args = { "lsp", "stdio" },
  filetypes = { "toml" },
  root_patterns = { "Cargo.toml", ".git" },
})

setup_server("bashls", {
  candidates = { "bash-language-server" },
  args = { "start" },
  filetypes = { "sh", "bash" },
  root_patterns = { ".git" },
})

setup_server("ruby_lsp", {
  candidates = { "ruby-lsp" },
  filetypes = { "ruby" },
  root_patterns = { "Gemfile", ".git" },
})

setup_server("rust_analyzer", {
  candidates = { "rust-analyzer" },
  filetypes = { "rust" },
  root_patterns = { "Cargo.toml", ".git" },
})

-- jsonls（保留原有 schemastore 设置）
setup_server("jsonls", {
  candidates = { "vscode-json-language-server", "json-languageserver" },
  args = { "--stdio" },
  filetypes = { "json", "jsonc" },
  root_patterns = { "package.json", ".git" },
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})

-- cssmodules_ls（保留原有 init_options）
setup_server("cssmodules_ls", {
  candidates = { "cssmodules-language-server" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_patterns = { "package.json", ".git" },
  init_options = { camelCase = false },
})

-- lua_ls（保留原有 NvChad 配置）
setup_server("lua_ls", {
  candidates = { "lua-language-server" },
  filetypes = { "lua" },
  root_patterns = { ".luarc.json", ".luarc.jsonc", ".git" },
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})

-- biome：按原逻辑仅在存在配置时尝试启动（若二进制存在）
local function has_biome_config()
  local biome_configs = { "biome.json", "biome.jsonc" }
  local function has_biome_in_package_json()
    local package_json = vim.fn.getcwd() .. "/package.json"
    if vim.fn.filereadable(package_json) == 1 then
      local content = vim.fn.readfile(package_json)
      local json_str = table.concat(content, "\n")
      return json_str:match('"biome"') ~= nil
    end
    return false
  end
  for _, config in ipairs(biome_configs) do
    if vim.fn.filereadable(vim.fn.getcwd() .. "/" .. config) == 1 then
      return true
    end
  end
  return has_biome_in_package_json()
end

if has_biome_config() then
  setup_server("biome", {
    candidates = { "biome" },
    args = { "lsp" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json" },
    root_patterns = { "biome.json", "biome.jsonc", "package.json", ".git" },
  })
end
