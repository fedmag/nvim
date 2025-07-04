return {
  {
    "echasnovski/mini.ai",
    version = "*",
    config = function()
      require("mini.ai").setup()
    end,
  },
  {
    "echasnovski/mini.pairs",
    enable = not vim.g.vscode,
    version = "*",
    config = function()
      require("mini.pairs").setup()
    end,
  },
  {
    "echasnovski/mini.surround",
    version = "*",
    config = function()
      require("mini.surround").setup()
    end,
  },
  {
    "echasnovski/mini.notify",
    enable = not vim.g.vscode,
    version = "*",
    config = function()
      require("mini.notify").setup()
    end,
  },
  {
    "echasnovski/mini.starter",
    version = "*",
    config = function()
      require("mini.starter").setup()
    end,
  },
  {
    "echasnovski/mini.move",
    version = "*",
    config = function()
      require("mini.move").setup()
    end,
  },
}
