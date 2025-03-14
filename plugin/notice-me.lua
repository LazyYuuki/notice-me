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
    -- Reapply highlights on all buffers
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].modifiable then
        vim.schedule(function()
          notice_me.highlight_keywords(buf)
        end)
      end
    end
    vim.notify("Keyword highlighting enabled")
  else
    -- Clear highlights on all buffers
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_clear_namespace(buf, notice_me.namespace, 0, -1)
      end
    end
    vim.notify("Keyword highlighting disabled")
  end
end, { desc = "Toggle notice-me keyword highlighting" })

-- Add command to refresh highlights
vim.api.nvim_create_user_command("NoticeMeRefresh", function()
  local notice_me = require("notice-me")
  if not notice_me.config.enable then
    vim.notify("Notice-me is disabled, enable it first with :NoticeMeToggle")
    return
  end

  -- Force refresh highlights on current buffer
  local bufnr = vim.api.nvim_get_current_buf()
  notice_me.highlight_keywords(bufnr)
  vim.notify("Refreshed keyword highlights")
end, { desc = "Refresh notice-me keyword highlighting" })

