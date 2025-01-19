# snacks-jumplist.nvim

A [snacks picker](https://github.com/folke/snacks.nvim/blob/main/docs/picker.md) extension that offers useful filters for the jump list.

The `jumplist` only shows result of current buffer.

# Installation

### lazy.nvim

```lua
{
    "vunhatchuong/snacks-jumplist.nvim",
    dependencies = { "folke/snacks.nvim" },
    keys = {
        { "<C-o>", "<CMD>SnacksJumplist<CR>" },
    },
    opts = {},
}
```

# Configuration

These are the default values, you can view it directly in [config.lua](./lua/snacks-jumplist/config.lua).

```lua
{
    ---@type integer? The maximum number of jump results to display.
    max_result = nil,

    ---@type integer? The minimum distance between lines to consider as separate jumps.
    line_distance_threshold = nil,
}

```
