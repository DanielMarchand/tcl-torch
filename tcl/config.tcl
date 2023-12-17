# config.tcl

set ::pythonExecutable "python3"

# Set the root directory of the project (one directory higher)
variable projectRoot [file dirname [file dirname [info script]]]

# Set the root directory of the project to the 'python' subdirectory
variable pythonRoot [file join [file dirname [file dirname [info script]]] "python"]

# Set the root directory of the project to the 'python' subdirectory
variable baseTmpDir [file join [file dirname [file dirname [info script]]] "resources/tmp"]

# Set the directory where the neural network models will be stored 
variable baseNNModelDir [file join [file dirname [file dirname [info script]]] "resources/nn_models"]

# Set the CSV storage location inside the project root
variable csvStorageLocation [file join $projectRoot "resources/data/csv"]
