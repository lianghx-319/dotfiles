local options = {
  ensure_installed = {
    -- spell check
    "cspell",

    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "tailwindcss-language-server",
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "prettier",
    "eslint_d",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- rust stuff
    "rust-analyzer",
  },
}

return options