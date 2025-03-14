# notice-me

A Neovim plugin that highlights important keywords in your code like TODO, BUG, and NOTE.

## Features

- Highlights keywords with different colors:
  - TODO (green)
  - BUG (red)
  - NOTE (yellow)
- Automatically applies highlighting when entering buffers or after saving
- Toggle keyword highlighting on/off with a command

## Installation

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
  'yourusername/notice-me',
  config = function()
    require('notice-me').setup({
      -- Optional custom configuration
    })
  end
}
```

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'yourusername/notice-me',
  config = function()
    require('notice-me').setup({
      -- Optional custom configuration
    })
  end
}
```

## Configuration

notice-me comes with the following defaults:

```lua
{
  enable = true,
  keywords = {
    TODO = { fg = "#00ff00" }, -- green
    BUG = { fg = "#ff0000" },  -- red
    NOTE = { fg = "#ffff00" }  -- yellow
  }
}
```

You can customize the plugin by passing options to the setup function:

```lua
require('notice-me').setup({
  enable = true, -- Enable/disable the plugin
  keywords = {
    TODO = { fg = "#00ff00" }, -- green
    BUG = { fg = "#ff0000" },  -- red
    NOTE = { fg = "#ffff00" },  -- yellow
    IMPORTANT = { fg = "#ff00ff" }, -- add your own keywords and colors
  }
})
```

## Usage

The plugin automatically highlights keywords in all buffers.

## Commands

- `:NoticeMe`: Display which keywords are being highlighted
- `:NoticeMeToggle`: Toggle keyword highlighting on/off

## API

```lua
-- Manually highlight keywords in the current buffer
require('notice-me').highlight_keywords(vim.api.nvim_get_current_buf())

-- Example function that displays highlighted keywords
require('notice-me').example_function()
```

## License

MIT
