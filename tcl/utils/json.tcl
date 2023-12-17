# untested 
# # Procedure to convert an associative array to JSON and write to a file
# proc assocArrayToJsonFile {assocArray filepath} {
#     set jsonParts {}

#     foreach key [array names assocArray] {
#         set value [set assocArray($key)]
#         lappend jsonParts [format {\"%s\": \"%s\"} $key $value]
#     }

#     set json "{"[join $jsonParts ", "]"}"

#     # Write the JSON string to the specified file
#     set configFile [open $filepath "w"]
#     puts $configFile $json
#     close $configFile
# }

# Procedure to convert a dictionary to JSON and write to a file
proc dictToJsonFile {dict filepath} {
    # Convert the dictionary to a JSON string
    package require json
    set json [json::write object {*}[dict get $dict]]

    # Write the JSON string to the specified file
    set configFile [open $filepath "w"]
    puts $configFile $json
    close $configFile
}
