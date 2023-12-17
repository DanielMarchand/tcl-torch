# Procedure to create a temporary directory
proc createTempDir {prefix} {
    # Generate a unique directory name using the current timestamp
    set timestamp [clock seconds]
    set tempDirName "${prefix}_${timestamp}"

    # Create the directory under the specified base directory
    set tempDirPath [file join $::TclTorch::baseTmpDir $tempDirName]
    file mkdir $tempDirPath

    return $tempDirPath
}

proc cleanupTmpDir {} {
    # Check if the directory exists
    if {[file exists $::TclTorch::baseTmpDir]} {
        # Delete the temporary directory itself
        file delete -force -- $::TclTorch::baseTmpDir
    }
}

