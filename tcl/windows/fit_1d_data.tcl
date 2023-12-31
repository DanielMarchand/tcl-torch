package require Tk
package require TclTorch

# Creating the Data Upload and Viewing Window
proc Fit1dDataViewWindow {} {
    set win [toplevel .fit1dDataViewWindow]
    wm title $win "Data Upload and Viewing"

    # Upload Button
    button $win.upload -text "Upload CSV" -command uploadCSV
    pack $win.upload -padx 10 -pady 10

    # View Button
    button $win.view -text "View Uploaded CSV" -command selectUploadedCSVs
    pack $win.view -padx 10 -pady 10

    # Design Architecture 
    button $win.design -text "Design Neural Network Architecture" -command createNNConfigWindow
    pack $win.design -padx 10 -pady 10

    # Train Neural Network 
    button $win.train -text "Train Neural Network" -command selectNeuralNetworkConfigs
    pack $win.train -padx 10 -pady 10
}

source "${::TclTorch::tclRoot}/windows/data_plotting_window.tcl"
source "${::TclTorch::tclRoot}/windows/neural_network_config_window.tcl"
source "${::TclTorch::tclRoot}/windows/csv_upload_view_window.tcl"
source "${::TclTorch::tclRoot}/windows/train_neuralnetwork_window.tcl"

# Call the function to create the window
Fit1dDataViewWindow
