return {
  {
    "vague2k/vague.nvim",
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
      require("vague").setup({
        -- optional configuration here
        vim.cmd.colorscheme("vague"),
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
      require("catppuccin").setup({
        -- optional configuration here
        -- vim.cmd.colorscheme("catppuccin"),
      })
    end,
  },
}
