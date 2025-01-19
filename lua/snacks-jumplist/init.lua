---@class SnacksJumplist
local M = {}

---@param user_opts? SnacksJumplistConfig
function M.setup(user_opts)
    local Config = require("snacks-jumplist.config")
    Config.setup(user_opts)

    local snacks = require("snacks-jumplist.jumplist")
    snacks.setup()
end

return M
