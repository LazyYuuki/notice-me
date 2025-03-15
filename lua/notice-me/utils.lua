local M = {}

function M.is_enabled()
  local notice_me = require("notice-me")
  return notice_me.config.enable
end

return M

