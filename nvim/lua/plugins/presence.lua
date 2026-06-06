return {
  "andweeb/presence.nvim",
  lazy = false, -- Load immediately on startup so Discord detects it right away
  config = function()
    require("presence").setup({
      -- General options
      auto_update = true,
      neovim_image_text = "The One True Text Editor",
      main_image = "neovim",
      log_level = nil,
      debounce_timeout = 10,
      enable_line_number = false,
      blacklist = {},
      buttons = true,
      file_assets = {},
      show_time = true, -- Crucial for showing elapsed time

      -- Rich Presence text options (English)
      editing_text = "Editing %s",
      file_explorer_text = "Browsing %s",
      git_commit_text = "Committing changes",
      plugin_manager_text = "Managing plugins",
      reading_text = "Reading %s",
      workspace_text = "Working on %s",
      line_number_text = "Line %d / %d",
    })
  end,
}
