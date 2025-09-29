local Basics = {}

Basics.shallow_copy = function(t)
    local t2 = {}
    for k, v in pairs(t) do
        t2[k] = v
    end
    return t2
end

Basics.dump = function(o, indent)
    indent = indent or 0
    local indentStr = string.rep("  ", indent)
    if type(o) == 'table' then
        local s = "{\n"
        for k, v in pairs(o) do
            local keyStr = type(k) == "number" and "[" .. k .. "]" or '["' .. tostring(k) .. '"]'
            s = s .. indentStr .. "  " .. keyStr .. " = " .. Basics.dump(v, indent + 1) .. ",\n"
        end
        return s .. indentStr .. "}"
    else
        return tostring(o)
    end
end

return Basics
