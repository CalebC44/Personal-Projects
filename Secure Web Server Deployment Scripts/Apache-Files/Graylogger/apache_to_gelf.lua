-- apache_to_gelf.lua
-- This script ensures that a GELF-compliant "short_message" field is present.
-- You can extract additional fields (e.g. timestamp, log level) as needed.

function apache_to_gelf(tag, timestamp, record)
    -- If the record does not have a 'short_message', use the 'log' field or a default message.
    if record["short_message"] == nil then
        if record["log"] ~= nil then
            record["short_message"] = record["log"]
        else
            record["short_message"] = "Apache log entry"
        end
    end

    -- Optionally, you can map/change fields here.
    -- For example: extract a timestamp from the log line if needed,
    -- or add a static field to indicate the source.
    record["source"] = "apache_error_log"

    -- Return the modified record (1 indicates success in this context)
    return 1, timestamp, record
end

