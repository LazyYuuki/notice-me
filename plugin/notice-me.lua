if vim.g.loaded_notice_me then
  return
end
vim.g.loaded_notice_me = true

-- Initialize the plugin
require("notice-me").setup()

-- Create user commands
vim.api.nvim_create_user_command("NoticeMe", function()
  require("notice-me").example_function()
end, { desc = "Example notice-me command" })

vim.api.nvim_create_user_command("NoticeMeToggle", function()
  local notice_me = require("notice-me")
  notice_me.config.enable = not notice_me.config.enable
  
  if notice_me.config.enable then
    -- Reapply highlights on current buffer
    notice_me.highlight_keywords(vim.api.nvim_get_current_buf())
    vim.notify("Keyword highlighting enabled")
  else
    -- Clear highlights on current buffer
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_clear_namespace(bufnr, notice_me.namespace, 0, -1)
    vim.notify("Keyword highlighting disabled")
  end
end, { desc = "Toggle notice-me keyword highlighting" })