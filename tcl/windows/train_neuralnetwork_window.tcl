package require Tk
package require TclTorch

# Procedure to select previously created neural network configurations
proc selectNeuralNetworkConfigs {} {
    global TclTorch::baseNNModelDir

    # Create a top-level window for neural network configuration selection
    set nnConfigSelectWindow [toplevel .nnConfigSelect]
    wm title $nnConfigSelectWindow "Select Neural Network Configuration"

    # List available config.json files within subdirectories of nnWeightsRoot
    set configFilePaths [glob -directory $TclTorch::baseNNModelDir -types {f} */config.json]

    # Extract just the filenames from the full paths
    set configFiles {}
    foreach path $configFilePaths {
        lappend configFiles [file tail [file dirname $path]]
    }

    # Create a dropdown menu for neural network configurations
    ttk::combobox $nnConfigSelectWindow.configDropdown -values $configFiles -state readonly
    pack $nnConfigSelectWindow.configDropdown -padx 10 -pady 10

    # Button to trigger the action based on the selected neural network configuration
    button $nnConfigSelectWindow.selectConfigBtn -text "Select Configuration" \
        -command [list useSelectedNNConfig $nnConfigSelectWindow.configDropdown $nnConfigSelectWindow]
    pack $nnConfigSelectWindow.selectConfigBtn -padx 10 -pady 10

}
# Function to plot and view the predictions CSV
proc plotAndViewPredictions {predictionsFilePath} {
    global TclTorch::tempPlotDir

    # Ensure temporary plot directory exists
    set tempPlotDir [TclTorch::createTempDir "plot"]

    # Create a top-level window for viewing predictions
    set predictionsViewWindow [toplevel .predictionsView]
    wm title $predictionsViewWindow "Prediction Plot"

    # Call Python script to plot the CSV
    set plotImagePath [TclTorch::execPython "python/plot_csv.py" [list $predictionsFilePath $tempPlotDir]]

    # Unpack the execution result to get the image path
    set exitStatus [lindex $plotImagePath 0]
    set imagePath [lindex $plotImagePath 1]

    if {$exitStatus == 0} {
        # Display the image in the predictions view window
        set image [image create photo -file $imagePath]
        label $predictionsViewWindow.plotImage -image $image
        pack $predictionsViewWindow.plotImage -padx 10 -pady 10
    } else {
        puts "Error in plotting CSV: $imagePath"
    }
}



# Function to use the selected neural network configuration and train and predict on data
proc useSelectedNNConfig {dropdownWidget window} {
    global TclTorch::baseNNModelDir

    # Get the selected configuration directory name
    set selectedConfigDir [$dropdownWidget get]
    set selectedConfigPath [file join $TclTorch::baseNNModelDir $selectedConfigDir]

    # Check if the train and predict button already exists and delete if it does
    if {[winfo exists $window.trainPredictBtn]} {
        destroy $window.trainPredictBtn
    }

    # Create a button to train and predict using the selected configuration
    button $window.trainPredictBtn -text "Train and Predict on Data" -command [list trainAndPredictOnData $selectedConfigPath]
    pack $window.trainPredictBtn -padx 10 -pady 10
}

# Function to perform both training and prediction
proc trainAndPredictOnData {configPath} {
    puts "Training and predicting for configuration at: $configPath"
    TclTorch::trainNeuralNetwork $configPath
    TclTorch::predictNeuralNetwork $configPath

    # Path to the predictions CSV
    set predictionsCSVPath [file join $configPath "predictions.csv"]

    # Plot and view the predictions CSV
    plotAndViewPredictions $predictionsCSVPath
}
