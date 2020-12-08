local M = {}

--- Split given string with given separator
--- and returns the result as a table.
function M.split(inputstr, separator)
        if separator == nil then
                separator = "%s"
        end

        local t = {}

        for str in string.gmatch(inputstr, "([^" ..separator .. "]+)") do
                table.insert(t, str)
        end

        return t
end

return M
