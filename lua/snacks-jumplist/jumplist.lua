local SnacksPicker = require("snacks.picker")

local Core = require("snacks-jumplist.core")
local Config = require("snacks-jumplist.config")

local M = {}

---@param opts SnacksJumplistConfig
---@return snacks.picker.finder.Item[] items
local function get_jumplist(opts)
    local jumplist = vim.fn.getjumplist()[1]

    local current_buffer = vim.fn.winbufnr(vim.fn.win_getid())

    local items = {} ---@type snacks.picker.finder.Item[]

    for _, jump in ipairs(jumplist) do
        local buf = jump.bufnr and vim.api.nvim_buf_is_valid(jump.bufnr) and jump.bufnr or 0
        local file = jump.filename or buf and vim.api.nvim_buf_get_name(buf) or nil

        if buf == current_buffer then
            local line ---@type string?
            if buf then
                line = vim.api.nvim_buf_get_lines(buf, jump.lnum - 1, jump.lnum, false)[1]
            end
            local label = tostring(#jumplist - #items)

            table.insert(items, 1, {
                label = SnacksPicker.util.align(label, #tostring(#jumplist), { align = "right" }),
                buf = buf,
                line = line,
                text = table.concat({ file, line }, " "),
                file = file,
                pos = jump.lnum and jump.lnum > 0 and { jump.lnum, jump.col } or nil,
            })
        end
    end

    items = Core.filter(items, opts)

    return items
end
function M.jumplist()
    local items = get_jumplist(Config.options)

    local layouts = require("snacks.picker.config.layouts")
    require("snacks.picker.config.layouts").default_smaller =
        vim.tbl_deep_extend("keep", { layout = { width = 0.5, height = 0.8 } }, layouts.default)

    SnacksPicker.pick({
        title = "Jumpbuff",
        items = items,
        format = "file",
        layout = { preset = "default_smaller" },
    })
end

function M.setup()
    vim.api.nvim_create_user_command("SnacksJumplist", function()
        M.jumplist()
    end, {})
end

return M
