package require Tk
package require TclTorch

# Procedure to save the model configuration as a JSON file
proc saveModelConfig {nnConfig modelName modelDir} {
    # File path for the JSON file
    set filePath [file join $modelDir "config.json"]

    # Ensure the modelDir directory exists, create it if necessary
    if {![file isdirectory $modelDir]} {
        file mkdir $modelDir
    }

    # Save the dictionary to a JSON file
    TclTorch::dictToJsonFile $nnConfig $filePath
}

# Procedure to confirm overwrite of an existing model
proc confirmOverwrite {nnConfigDict modelName modelDir nnConfigWindow} {
    set confirmWindow [toplevel .confirmOverwrite]
    wm title $confirmWindow "Confirm Overwrite"

    label $confirmWindow.msg -text "Model already exists. Overwrite?"
    button $confirmWindow.yesBtn -text "Yes" -command [list performOverwrite $nnConfigDict $modelName $modelDir $nnConfigWindow $confirmWindow]
    button $confirmWindow.noBtn -text "No" -command [list destroy $confirmWindow]

    pack $confirmWindow.msg -padx 10 -pady 10
    pack $confirmWindow.yesBtn -padx 10 -pady 5
    pack $confirmWindow.noBtn -padx 10 -pady 5
}


# Procedure to perform overwrite
proc performOverwrite {nnConfigDict modelName modelDir nnConfigWindow confirmWindow} {
    file delete -force -- $modelDir
    saveModelConfig $nnConfigDict $modelName $modelDir
    destroy $confirmWindow
    destroy $nnConfigWindow
}


# Procedure to store the model configuration
proc storeModel {nnConfigWindow} {
    global nnConfig modelName 
    
    # baseNNModelDir

    # Convert the associative array to a dictionary
    set nnConfigDict [array get nnConfig]

    # Model directory path
    set modelDir [file join $TclTorch::baseNNModelDir $modelName]

    # Check if the model directory already exists
    if {[file exists $modelDir]} {
        confirmOverwrite $nnConfigDict $modelName $modelDir $nnConfigWindow
    } else {
        saveModelConfig $nnConfigDict $modelName $modelDir
        destroy $nnConfigWindow
    }
}

# Function to list available CSV files in a directory
proc listAvailableCSVs {directory} {
    set csvFiles [glob -nocomplain -directory $directory -types {f} *.csv]
    set csvFileNames {}
    foreach path $csvFiles {
        lappend csvFileNames [file tail $path]
    }
    return $csvFileNames
}

# Procedure to create the Neural Network Configuration Window
proc createNNConfigWindow {} {
    global TclTorch::csvStorageLocation
    variable nnConfig 
    variable modelName "your_model_name"

    # Initialize the associative array with default values
    set nnConfig(neuronsPerLayer) 40
    set nnConfig(numLayers) 2
    #set nnConfig(numNetworks) 5
    set nnConfig(learningRate) 5e-3
    set nnConfig(epochs) 500
    set nnConfig(logInterval) 10

    set nnConfigWindow [toplevel .nnConfig]
    wm title $nnConfigWindow "Neural Network Configuration"

    # Create widgets for each configuration option and bind them to the associative array
    label $nnConfigWindow.neuronsLbl -text "Neurons Per Layer:"
    entry $nnConfigWindow.neuronsEntry -textvariable nnConfig(neuronsPerLayer)

    label $nnConfigWindow.layersLbl -text "Number of Layers:"
    entry $nnConfigWindow.layersEntry -textvariable nnConfig(numLayers)

    #label $nnConfigWindow.networksLbl -text "Number of Networks:"
    #entry $nnConfigWindow.networksEntry -textvariable nnConfig(numNetworks)

    label $nnConfigWindow.lrLbl -text "Learning Rate:"
    entry $nnConfigWindow.lrEntry -textvariable nnConfig(learningRate)

    label $nnConfigWindow.epochsLbl -text "Epochs:"
    entry $nnConfigWindow.epochsEntry -textvariable nnConfig(epochs)

    label $nnConfigWindow.logLbl -text "Log Interval:"
    entry $nnConfigWindow.logEntry -textvariable nnConfig(logInterval)

    label $nnConfigWindow.modelNameLbl -text "Model Name:"
    entry $nnConfigWindow.modelNameEntry -textvariable modelName

    # GPU Usage (Radio Button)
    label $nnConfigWindow.gpuLbl -text "Use GPU:"
    radiobutton $nnConfigWindow.gpuYes -text "Yes" -state disabled -value True
    radiobutton $nnConfigWindow.gpuNo -text "No" -value False


    # Create a dropdown menu for selecting training data
    label $nnConfigWindow.trainingDataLbl -text "Training Data:"
    ttk::combobox $nnConfigWindow.trainingDataCombo -textvariable nnConfig(trainingData) -state readonly

    # Populate the dropdown with CSV file names
    set csvFiles [listAvailableCSVs $TclTorch::csvStorageLocation]
    $nnConfigWindow.trainingDataCombo configure -values $csvFiles


    # Store Model Button
    button $nnConfigWindow.storeModelBtn -text "Store Model" -command [list storeModel $nnConfigWindow]

    # Arrange widgets using grid
    grid $nnConfigWindow.neuronsLbl $nnConfigWindow.neuronsEntry
    grid $nnConfigWindow.layersLbl $nnConfigWindow.layersEntry
    #grid $nnConfigWindow.networksLbl $nnConfigWindow.networksEntry
    grid $nnConfigWindow.lrLbl $nnConfigWindow.lrEntry
    grid $nnConfigWindow.epochsLbl $nnConfigWindow.epochsEntry
    grid $nnConfigWindow.logLbl $nnConfigWindow.logEntry
    grid $nnConfigWindow.modelNameLbl $nnConfigWindow.modelNameEntry
    grid $nnConfigWindow.gpuLbl $nnConfigWindow.gpuYes $nnConfigWindow.gpuNo
    # Arrange the new training data widgets using grid
    grid $nnConfigWindow.trainingDataLbl $nnConfigWindow.trainingDataCombo

    grid $nnConfigWindow.storeModelBtn
}

