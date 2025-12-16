local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local function lspsaga_key_mappings(buffer)
  local map = vim.keymap.set
  -- lspsaga
  map("n", "gh", "<cmd>Lspsaga finder<cr>", { desc = "Lspsaga finder", buffer = buffer })
  map({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<cr>", { desc = "Lspsaga code action", buffer = buffer })
  map("n", "gr", "<cmd>Lspsaga rename<cr>", { desc = "Lspsaga rename", buffer = buffer })
  map("n", "gp", "<cmd>Lspsaga peek_definition<cr>", { desc = "Lspsaga peek definition", buffer = buffer })
  map("n", "gd", "<cmd>Lspsaga goto_definition<cr>", { desc = "Lspsaga goto definition", buffer = buffer })
  map("n", "gt", "<cmd>Lspsaga peek_type_definition<cr>", { desc = "Lspsaga peek type definition", buffer = buffer })
  map(
    "n",
    "<leader>sl",
    "<cmd>Lspsaga show_line_diagnostics<cr>",
    { desc = "Lspsaga show line diagnostics", buffer = buffer }
  )
  map(
    "n",
    "<leader>sw",
    "<cmd>Lspsaga show_workspace_diagnostics<cr>",
    { desc = "Lspsaga show workspace diagnostics", buffer = buffer }
  )
  map(
    "n",
    "<leader>sc",
    "<cmd>Lspsaga show_cursor_diagnostics<cr>",
    { desc = "Lspsaga show cursor diagnostics", buffer = buffer }
  )
  map("n", "[e", function()
    require("lspsaga.diagnostic"):goto_prev { severity = vim.diagnostic.severity.ERROR }
  end, { desc = "Lspsaga goto prev diagnostic", buffer = buffer })
  map("n", "]e", function()
    require("lspsaga.diagnostic"):goto_next { severity = vim.diagnostic.severity.ERROR }
  end, { desc = "Lspsaga goto next diagnostics", buffer = buffer })
  map("n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Lspsaga hover doc", buffer = buffer })
  map("n", "<leader>o", "<cmd>Lspsaga outline<cr>", { desc = "Lspsaga outline", buffer = buffer })
  map("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<cr>", { desc = "Lspsaga incoming calls", buffer = buffer })
  map("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<cr>", { desc = "Lspsaga outgoing calls", buffer = buffer })
end

local function custom_on_attach(client, buffer)
  on_attach(client, buffer)
  lspsaga_key_mappings(buffer)
end

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "ts_ls", "clangd", "tailwindcss", "taplo", "bashls", "ruby_lsp", "rust_analyzer" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = custom_on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- jsonls
lspconfig.jsonls.setup {
  on_attach = custom_on_attach,
  on_init = on_init,
  capabilities = capabilities,

  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}

lspconfig.cssmodules_ls.setup {
  on_attach = custom_on_attach,
  on_init = on_init,
  capabilities = capabilities,

  init_options = {
    camelCase = false,
  },
}

-- lua_ls
lspconfig.lua_ls.setup {
  on_attach = custom_on_attach,
  on_init = on_init,
  capabilities = capabilities,

  -- copy from nvchad https://github.com/NvChad/NvChad/blob/020b8e4428d6d6ed3cf1d6afc899cb2f76aab1a0/lua/nvchad/configs/lspconfig.lua#L73
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
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
}

-- biome
local function has_biome_config()
  -- 检查 biome 配置文件
  local biome_configs = {
    "biome.json",
    "biome.jsonc",
  }
  
  -- 检查 package.json 中是否有 biome 配置
  local function has_biome_in_package_json()
    local package_json = vim.fn.getcwd() .. "/package.json"
    if vim.fn.filereadable(package_json) == 1 then
      local content = vim.fn.readfile(package_json)
      local json_str = table.concat(content, "\n")
      return json_str:match('"biome"') ~= nil
    end
    return false
  end
  
  -- 检查配置文件是否存在
  for _, config in ipairs(biome_configs) do
    if vim.fn.filereadable(vim.fn.getcwd() .. "/" .. config) == 1 then
      return true
    end
  end
  
  return has_biome_in_package_json()
end

-- 只有在检测到 biome 配置时才设置 biome LSP
if has_biome_config() then
  lspconfig.biome.setup {
    on_attach = custom_on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end
