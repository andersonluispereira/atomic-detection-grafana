-- Define the specific keys to look for
local TARGET_KEYS = { "proctitle" }

function is_valid_hex(str)
    if #str % 2 ~= 0 then return false end
    return string.match(str, "^[%x]+$") ~= nil
end

function hex_to_ascii(hex_str)
    return (hex_str:gsub('..', function (cc)
        local byte = tonumber(cc, 16)
        return (byte >= 32 and byte <= 126) and string.char(byte) or " "
    end))
end

function hex(tag, timestamp, record)
    local modified = false
 
    -- Only iterate over the specific keys we care about
    for _, key in ipairs(TARGET_KEYS) do
        local value = record[key]

        -- Process only if the key exists in the record and is a valid hex string
        if type(value) == "string" and is_valid_hex(value) then
            record[key] = hex_to_ascii(value)
            modified = true
        end
    end

    -- Return 1 (modified) or 0 (no change) for better Fluent Bit performance
    return modified and 1 or 0, timestamp, record
end
