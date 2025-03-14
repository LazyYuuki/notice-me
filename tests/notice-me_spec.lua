local notice_me = require("notice-me")

describe("notice-me", function()
  it("can be required", function()
    assert.truthy(notice_me)
  end)

  it("has setup function", function()
    assert.truthy(notice_me.setup)
    assert.is_function(notice_me.setup)
  end)

  it("has example_function", function()
    assert.truthy(notice_me.example_function)
    assert.is_function(notice_me.example_function)
  end)

  it("can be configured", function()
    local original_config = vim.deepcopy(notice_me.config)
    
    -- Test with custom config
    notice_me.setup({ enable = false })
    assert.equals(false, notice_me.config.enable)
    
    -- Reset config
    notice_me.config = original_config
  end)
end)