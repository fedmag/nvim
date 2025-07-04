return {
  'rmagatti/auto-session',
  lazy = false,
  enabled = not vim.g.vscode,
  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  config = function()
    require('auto-session').setup({
    })
  end,
  opts = {
    suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    -- log_level = 'debug',
  }
}
