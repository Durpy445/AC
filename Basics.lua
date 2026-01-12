local Basics = {}

Basics.shallow_copy = function(t)
    local t2 = {}
    for k, v in pairs(t) do
        t2[k] = v
    end
    return t2
end

Basics.deep_copy = function(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[Basics.deep_copy(orig_key)] = Basics.deep_copy(orig_value)
        end
        setmetatable(copy, Basics.deep_copy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

Basics.RandomFromTable = function(RandomTable)
    if #RandomTable == 0 then
        local nums = {}
        for i, x in pairs(RandomTable) do
            print(i)
            table.insert(nums, i)
        end
        return (RandomTable[Basics.RandomFromTable(nums)])
    end
    return RandomTable[math.random(1, #RandomTable)]
end

Basics.dump = function(o, indent)
    indent = indent or 0
    local indentStr = string.rep("  ", indent)
    if type(o) == 'table' then
        local s = "{\n"
        for k, v in pairs(o) do
            local keyStr = type(k) == "number" and "[" .. k .. "]" or '["' .. tostring(k) .. '"]'
            --print(keyStr)
            s = s .. indentStr .. "  " .. keyStr .. " = " .. Basics.dump(v, indent + 1) .. ",\n"
        end
        return s .. indentStr .. "}"
    else
        return tostring(o)
    end
end

Basics.FindMatch = function(Haystack, Needle)
    for key, value in pairs(Haystack) do
        if value == Needle then
            return key
        end
    end
    return nil
end

Basics.FindAndRemove = function(Haystack, Needle)
    local Index = Basics.FindMatch(Haystack, Needle)
    table.remove(Haystack, Index)
end

return Basics
