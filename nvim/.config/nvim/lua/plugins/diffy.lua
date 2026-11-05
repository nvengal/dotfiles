return {
  {
    dir = "~/nvengal/talk-diffy-to-me",
    name = "diffy",
    cmd = { "Diffy", "DiffyComment", "DiffyEdit", "DiffyDelete", "DiffySend", "DiffyReview", "DiffyRepick" },
    keys = {
      { "<leader>v", "", desc = "+review" },
      { "<leader>vv", "<cmd>Diffy<cr>", desc = "Review jj diff" },
      { "<leader>vc", ":DiffyComment<cr>", mode = { "n", "x" }, desc = "Comment" },
      { "<leader>vd", "<cmd>DiffyDelete<cr>", desc = "Delete comment" },
      { "<leader>vs", "<cmd>DiffySend<cr>", desc = "Send comment (review if several)" },
      { "<leader>vS", "<cmd>DiffySend!<cr>", desc = "Send all comments" },
      { "<leader>vr", "<cmd>DiffyReview<cr>", desc = "Review pending comments" },
      { "<leader>vp", "<cmd>DiffyRepick<cr>", desc = "Repick pane" },
    },
  },
}
