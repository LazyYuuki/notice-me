local M = {}

-- Example utility function
function M.is_enabled()
  local notice_me = require("notice-me")
  return notice_me.config.enable
end

-- Add more utility functions as needed

return M