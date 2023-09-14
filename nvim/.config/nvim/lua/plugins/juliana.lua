return {
  -- add juliana colorscheme
  { "kaiuri/nvim-juliana" },

  -- Configure LazyVim to load juliana
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nvim-juliana",
    },
  },
}
