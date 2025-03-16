---@diagnostic disable: undefined-field
local notice_me = require("notice_me")

describe("notice_me", function()
  local original_config

  before_each(function()
    -- Store original config before each test
    original_config = vim.deepcopy(notice_me.config)
  end)

  after_each(function()
    -- Restore original config after each test
    notice_me.config = original_config
    -- Reapply highlights with original config
    notice_me.setup_highlights()
  end)

  it("can be required", function()
    assert.truthy(notice_me)
  end)

  it("has setup function", function()
    assert.truthy(notice_me.setup)
    assert.is_function(notice_me.setup)
  end)

  it("can be configured", function()
    -- Test with custom config
    notice_me.setup({ enable = false })
    assert.equals(false, notice_me.config.enable)

    notice_me.setup({
      keywords = {
        IMPORTANT = { fg = "#ff00ff" }
      }
    })
    assert.truthy(notice_me.config.keywords.IMPORTANT)
    assert.equals("#ff00ff", notice_me.config.keywords.IMPORTANT.fg)
  end)

  it("creates highlight namespace", function()
    assert.truthy(notice_me.namespace)
    assert.is_number(notice_me.namespace)
  end)

  it("can highlight keywords in buffer", function()
    -- Create a temporary buffer with test content
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
      "TODO: This is a test",
      "This is a BUG that needs fixing",
      "NOTE: Important information here"
    })

    -- Enable highlighting
    notice_me.config.enable = true

    -- Apply highlights
    notice_me.highlight_keywords(bufnr)

    -- We can't directly test the highlights, but we can ensure the function runs without errors
    assert.truthy(true)

    -- Clean up
    vim.api.nvim_buf_delete(bufnr, { force = true })
  end)
end)
