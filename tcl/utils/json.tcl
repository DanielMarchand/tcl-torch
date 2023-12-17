# Procedure to convert a dictionary to JSON and write to a file
proc dictToJsonFile {dict filepath} {
    package require json::write

    # Initialize an empty list to hold JSON key-value pairs
    set jsonKeyValuePairs {}

    # Iterate over the dictionary and format each key-value pair as JSON
    foreach {key value} [dict get $dict] {
        if {[string is double -strict $value]} {
            # Numbers: add directly as value
            lappend jsonKeyValuePairs $key $value
        } else {
            # Strings and other types: convert value to a JSON string
            lappend jsonKeyValuePairs $key [json::write string $value]
        }
    }

    # Combine key-value pairs into a single JSON object
    set json_content [json::write object {*}$jsonKeyValuePairs]

    # Write the JSON string to the specified file
    set configFile [open $filepath "w"]
    puts $configFile $json_content
    close $configFile
}

