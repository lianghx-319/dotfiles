return {
  {
    "dmmulroy/ts-error-translator.nvim",
    event = "LspAttach",
    ft = { "typescript", "typescriptreact" },
    config = function(_, opts)
      require("ts-error-translator").setup(opts)
    end,
  },
}
