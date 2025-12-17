-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  statusline = {
    theme = "vscode_colored",
    separator_style = "arrow",
    modules = nil,
  },
}

M.base46 = {
  theme = "everforest",
  transparency = true,
}

M.nvdash = {
  load_on_startup = true,
  header = (function()
    -- 保留原始文案（含宽字符）
    local raw = {
      "                                                                       ",
      "                                                                     ",
      "       ████ ██████           █████      ██                     ",
      "      ███████████             █████                             ",
      "      █████████ ███████████████████ ███   ███████████   ",
      "     █████████  ███    █████████████ █████ ██████████████   ",
      "    █████████ ██████████ █████████ █████ █████ ████ █████   ",
      "  ███████████ ███    ███ █████████ █████ █████ ████ █████  ",
      " ██████  █████████████████████ ████ █████ █████ ████ ██████ ",
      "                                                                       ",
      "                                                                       ",
      "                                                                       ",
    }
    -- 根据当前窗口宽度裁剪，避免 Column 越界
    local columns = vim.o.columns
    local margin = 2
    local maxw = math.max(20, columns - margin)
    local function clip(s, width)
      local w = vim.fn.strdisplaywidth(s)
      if w <= width then return s end
      local out = ""
      local acc = 0
      for _, ch in ipairs(vim.fn.split(s, "\\zs")) do
        local cw = vim.fn.strdisplaywidth(ch)
        if acc + cw > width then break end
        out = out .. ch
        acc = acc + cw
      end
      return out
    end
    local res = {}
    for _, s in ipairs(raw) do
      table.insert(res, clip(s, maxw))
    end
    return res
  end)(),
}

return M
