return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "onedark",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "filename",
            path = 3,       -- 1 shows the relative path from the current working directory
            shorting_target = 40, -- shorten the path if it exceeds this length
          },
        },
        lualine_x = { "filetype" },
        lualine_y = { "diff" },
        lualine_z = { "diagnostic" },
      },
    })
  end,
}
