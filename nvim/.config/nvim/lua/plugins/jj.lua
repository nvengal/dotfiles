local function jj(module, fn, args)
  return function()
    require("jj." .. module)[fn](args)
  end
end

return {
  {
    "NicolasGB/jj.nvim",
    version = "*",
    cmd = { "J", "Jbrowse", "Jdiff", "Jhdiff", "Jvdiff", "Jedit", "Jread", "Jsplit", "Jtabedit", "Jvsplit" },
    keys = {
      { "<leader>j", "", desc = "+jj" },
      { "<leader>jd", jj("cmd", "describe"), desc = "Describe" },
      { "<leader>jl", jj("cmd", "log"), desc = "Log" },
      { "<leader>jL", jj("cmd", "log", { revisions = "'all()'" }), desc = "Log all" },
      { "<leader>je", jj("cmd", "edit"), desc = "Edit" },
      { "<leader>jn", jj("cmd", "new"), desc = "New" },
      { "<leader>js", jj("cmd", "status"), desc = "Status" },
      { "<leader>jq", jj("cmd", "squash"), desc = "Squash" },
      { "<leader>ju", jj("cmd", "undo"), desc = "Undo" },
      { "<leader>jy", jj("cmd", "redo"), desc = "Redo" },
      { "<leader>jr", jj("cmd", "rebase"), desc = "Rebase" },
      { "<leader>jx", jj("cmd", "abandon"), desc = "Abandon" },
      { "<leader>jf", jj("cmd", "fetch"), desc = "Fetch" },
      { "<leader>ja", jj("annotate", "file"), desc = "Annotate file" },
      { "<leader>jA", jj("annotate", "line"), desc = "Annotate line" },
      { "<leader>jB", ":Jbrowse<cr>", mode = { "n", "x" }, desc = "Browse on remote" },
      { "<leader>jv", jj("diff", "open_vdiff"), desc = "Diff buffer (vertical)" },
      { "<leader>jh", jj("diff", "open_hdiff"), desc = "Diff buffer (horizontal)" },

      { "<leader>jb", "", desc = "+bookmark" },
      { "<leader>jbc", jj("cmd", "bookmark_create"), desc = "Create" },
      { "<leader>jbd", jj("cmd", "bookmark_delete"), desc = "Delete" },
      { "<leader>jbm", jj("cmd", "bookmark_move"), desc = "Move" },

      { "<leader>jt", "", desc = "+tag" },
      { "<leader>jts", jj("cmd", "tag_set"), desc = "Set" },
      { "<leader>jtd", jj("cmd", "tag_delete"), desc = "Delete" },
      { "<leader>jtp", jj("cmd", "tag_push"), desc = "Push" },

      { "<leader>jp", "", desc = "+push/PR" },
      { "<leader>jpp", jj("cmd", "push"), desc = "Push" },
      { "<leader>jpr", jj("cmd", "open_pr"), desc = "Open PR" },
      { "<leader>jpl", jj("cmd", "open_pr", { list_bookmarks = true }), desc = "Open PR (pick bookmark)" },

      { "<leader>jg", "", desc = "+picker" },
      { "<leader>jgg", jj("picker", "status"), desc = "Status" },
      { "<leader>jgh", jj("picker", "file_history"), desc = "File history" },
      { "<leader>jgc", jj("picker", "conflict"), desc = "Conflicts" },
      { "<leader>jgs", jj("picker", "conflict_sections"), desc = "Conflict sections" },
    },
    opts = {},
  },
}
