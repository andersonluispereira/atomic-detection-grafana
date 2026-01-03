function audit_timestamp_seqid(tag, timestamp, record)
    local msg = record["msg"]
    if not msg then return 0, 0, 0 end

    -- Extract the two number groups separated by a colon
    -- %d+ matches digits, %. matches the literal dot
    local ts_raw, seq = string.match(msg, "(%d+%.%d+):(%d+)")

    if ts_raw and seq then
        -- Remove the dot from the timestamp string
        record["timestamp"] = string.gsub(ts_raw, "%.", "")
        record["seqid"] = seq
        
        -- Optional: Remove original msg to keep only cleaned fields
        -- record["msg"] = nil 
        
        return 1, timestamp, record
    end

    return 0, 0, 0
end
