function extract_record(tag, timestamp, record)

    -- Check if snapshot exists and is a table
    if record["snapshot"] and type(record["snapshot"]) == "table" then
	local new_records = {}    

        for i, item in ipairs(record["snapshot"]) do
            -- Create a flattened record for each interface
 	    if record["name"] ~= nil then
	    	item["name"] = record["name"]
	    end 
            table.insert(new_records, item)
        end

        return 1, timestamp, new_records

    -- 2. Check for 'columns' (Map format)
    elseif record["columns"] ~= nil then
        local new_record = nil

        new_record = record["columns"]
        if record["name"] ~= nil then
            new_record["name"] = record["name"]
        end

        return 1, timestamp, new_record
    end

    return 0, timestamp, record
end
