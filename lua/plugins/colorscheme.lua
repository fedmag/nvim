return {
  {
    "vague2k/vague.nvim",
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
      require("vague").setup({
        -- optional configuration here
        -- vim.cmd.colorscheme("vague"),
      })
    end,
  },
  {
    "thesimonho/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa-paper').setup({
        transparent = true,
        color_balance = {
          ink = { brightness = 0, saturation = 0 },
        },
      })
      vim.cmd.colorscheme("kanagawa-paper-ink")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme("kanagawa-dragon")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        -- vim.cmd.colorscheme("catppuccin"),
      })
    end,
  },
}
