local M = {}

--- Filter based on opts
---
---@param items snacks.picker.finder.Item[]
---@param opts SnacksJumplistConfig
---@return snacks.picker.finder.Item[] results
function M.filter(items, opts)
    local result = {} ---@type snacks.picker.finder.Item[]

    if opts.line_distance_threshold then
        for _, jump in ipairs(items) do
            local should_add = true

            for _, added_jump in ipairs(result) do
                if math.abs(jump.pos[1] - added_jump.pos[1]) <= opts.line_distance_threshold then
                    should_add = false
                    break
                end
            end

            if should_add then
                table.insert(result, jump)
            end
        end
    else
        result = { unpack(items) }
    end

    if opts.max_result and #result > opts.max_result then
        result = vim.list_slice(result, 1, opts.max_result)
    end

    return result
end

return M
