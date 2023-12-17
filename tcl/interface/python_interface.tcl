# Procedures to handle calling Python scripts and processing their outputs
# Set the path to the Python executable
set ::pythonExecutable "python3"

# Executes a Python script and returns its output
proc execPython {scriptPath args} {
    global pythonExecutable

    # Construct the command to execute the Python script
    set command [list $pythonExecutable $scriptPath {*}$args]

    # Execute the command and capture the output and return status
    set returnStatus [catch {eval exec {*}$command} result]

    # Return a list containing the return status and the result/output
    return [list $returnStatus $result]
}

# Procedure to check Python and dependencies
proc checkPythonAndDependencies {} {
    # Path to the Python script that checks dependencies
    set pythonScript "${::TclTorch::projectRoot}/python/tests/check_dependencies.py"

    # Use execPython to execute the Python script
    set executionResult [execPython $pythonScript {}]

    # Extract the return status and result from the execution result
    set exitStatus [lindex $executionResult 0]
    set result [lindex $executionResult 1]

    # Check the exit status
    if {$exitStatus == 0} {
        puts "Test passed: Python and all dependencies are available."
    } else {
        puts "Test failed: $result (exit status: $exitStatus)"
    }
}
