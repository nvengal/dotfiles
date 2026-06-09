return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      diagnostics = {
        virtual_text = {
          severity = { min = vim.diagnostic.severity.INFO },
        },
        signs = {
          severity = { min = vim.diagnostic.severity.INFO },
        },
        jump = {
          severity = { min = vim.diagnostic.severity.INFO },
        },
      },
      servers = {
        basedpyright = {
          -- Temp disable for ty
          filetypes = {},
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "standard",
              },
            },
          },
        },
        ty = {},
        ruff = {
          -- use only for formatting with `conform`
          filetypes = {},
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = {
          -- To fix auto-fixable lint errors.
          "ruff_fix",
          -- To run the Ruff formatter.
          "ruff_format",
          -- To organize the imports.
          "ruff_organize_imports",
        },
      },
    },
  },
}
