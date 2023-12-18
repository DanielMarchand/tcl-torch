# Procedures to handle calling Python scripts and processing their outputs
# Set the path to the Python executable

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

# Function to save and validate a CSV file using Python
proc saveValidateCSV {inputPath} {
    global pythonExecutable csvStorageLocation

    set pythonScript "${::TclTorch::pythonRoot}/save_and_validate_csv.py"
    set args [list $inputPath $::TclTorch::csvStorageLocation]

    # Use execPython to execute the Python script
    set executionResult [execPython $pythonScript $args]

    # Extract the return status and result
    set exitStatus [lindex $executionResult 0]
    set result [lindex $executionResult 1]

    if {$exitStatus != 0 || [string match "Error:*" $result]} {
        puts "Error in processing CSV: $result"
    } else {
        puts $result
    }
}
# Procedure to train the neural network model using Python script
proc trainNeuralNetwork {modelDir} {
    set pythonScript "${::TclTorch::pythonRoot}/simple_nn.py"
    set args [list $modelDir train]

    # Use execPython to execute the Python script in 'train' mode
    set executionResult [execPython $pythonScript $args]

    # Handle the execution result
    set exitStatus [lindex $executionResult 0]
    set result [lindex $executionResult 1]

    if {$exitStatus == 0} {
        puts "Training completed successfully."
    } else {
        puts "Error in training model: $result"
    }
}

# Procedure to predict using the neural network model using Python script
proc predictNeuralNetwork {modelDir} {
    set pythonScript "${::TclTorch::pythonRoot}/simple_nn.py"
    set args [list $modelDir predict]

    # Use execPython to execute the Python script in 'predict' mode
    set executionResult [execPython $pythonScript $args]

    # Handle the execution result
    set exitStatus [lindex $executionResult 0]
    set result [lindex $executionResult 1]

    if {$exitStatus == 0} {
        puts "Prediction completed successfully."
    } else {
        puts "Error in prediction: $result"
    }
}
