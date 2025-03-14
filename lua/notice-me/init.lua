local M = {}

-- Plugin configuration with default values
M.config = {
  enable = true,
  keywords = {
    TODO = { fg = "#00ff00" }, -- green
    BUG = { fg = "#ff0000" },  -- red
    NOTE = { fg = "#ffff00" }  -- yellow
  }
}

-- Function to setup the plugin with user config
function M.setup(opts)
  -- Merge user config with defaults
  opts = opts or {}
  M.config = vim.tbl_deep_extend("force", M.config, opts)
  
  -- Initialize your plugin here
  M.setup_highlights()
  M.setup_autocmds()

  -- Return the module for chaining
  return M
end

-- Set up highlights for keywords
function M.setup_highlights()
  local ns_id = vim.api.nvim_create_namespace("notice_me")
  M.namespace = ns_id
  
  -- Create highlight groups
  for keyword, color in pairs(M.config.keywords) do
    vim.api.nvim_set_hl(0, "NoticeMe" .. keyword, color)
  end
end

-- Set up autocommands to apply highlighting
function M.setup_autocmds()
  vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost"}, {
    callback = function(args)
      if not M.config.enable then return end
      M.highlight_keywords(args.buf)
    end,
    desc = "Notice-me highlight keywords on buffer enter/write",
  })
  
  -- Also highlight current buffer immediately
  vim.schedule(function()
    if vim.api.nvim_get_current_buf() then
      M.highlight_keywords(vim.api.nvim_get_current_buf())
    end
  end)
end

-- Highlight keywords in a buffer
function M.highlight_keywords(bufnr)
  if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then return end
  
  -- Clear previous highlights
  vim.api.nvim_buf_clear_namespace(bufnr, M.namespace, 0, -1)
  
  -- Get buffer content
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  
  -- Highlight keywords
  for i, line in ipairs(lines) do
    for keyword, _ in pairs(M.config.keywords) do
      local start_idx = 1
      while true do
        local match_start, match_end = line:find(keyword, start_idx)
        if not match_start then break end
        
        -- Apply highlight
        vim.api.nvim_buf_add_highlight(
          bufnr,
          M.namespace,
          "NoticeMe" .. keyword,
          i - 1,
          match_start - 1,
          match_end
        )
        
        start_idx = match_end + 1
      end
    end
  end
end

-- Example function implementation
function M.example_function()
  print("Notice-me plugin function called!")
  print("Keywords being highlighted:", vim.inspect(vim.tbl_keys(M.config.keywords)))
end

return M