-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- explicitly setup gitlinker to use required function
require("gitlinker").setup({
  opts = {
    action_callback = require"gitlinker.actions".open_in_browser,
  },
})
