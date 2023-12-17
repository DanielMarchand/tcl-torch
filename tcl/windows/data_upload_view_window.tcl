package require Tk
package require TclTorch

# Procedure to open a file dialog and upload a CSV file
proc uploadCSV {} {
    # Use tk_getOpenFile to let the user select a CSV file
    set filename [tk_getOpenFile -filetypes {{"CSV Files" ".csv"}}]
    if {$filename != ""} {
        TclTorch::saveValidateCSV $filename
    }
}

# Procedure to select previously uploaded CSV/models
proc selectUploadedCSVs {} {
    global TclTorch::csvStorageLocation

    # Create a top-level window for CSV selection
    set csvSelectWindow [toplevel .csvSelect]
    wm title $csvSelectWindow "Select CSV Plot"

    # List available CSV files with full paths
    set csvFilePaths [glob -directory $TclTorch::csvStorageLocation -types {f} *.csv]

    # Extract just the filenames from the full paths
    set csvFiles {}
    foreach path $csvFilePaths {
        lappend csvFiles [file tail $path]
    }

    # Create a dropdown menu for CSV files
    ttk::combobox $csvSelectWindow.csvDropdown -values $csvFiles -state readonly
    pack $csvSelectWindow.csvDropdown -padx 10 -pady 10

    # Button to trigger plot and view of the selected CSV
    button $csvSelectWindow.plotAndViewBtn -text "Plot and View CSV" -command [list plotAndViewCSV $csvSelectWindow.csvDropdown]
    pack $csvSelectWindow.plotAndViewBtn -padx 10 -pady 10
}


# Function to plot and view the selected CSV
proc plotAndViewCSV {dropdownWidget} {
    global TclTorch::csvStorageLocation tempPlotDir
    set tempPlotDir [TclTorch::createTempDir  "plot"]

    # Get selected CSV file name
    set selectedCSV [$dropdownWidget get]
    set fullCSVPath "${TclTorch::csvStorageLocation}/${selectedCSV}"

    # Call Python script to plot the CSV
    set plotImagePath [TclTorch::execPython "python/plot_csv.py" [list $fullCSVPath $tempPlotDir]]

    # Unpack the execution result to get the image path
    set exitStatus [lindex $plotImagePath 0]
    set imagePath [lindex $plotImagePath 1]

    if {$exitStatus == 0} {
        # Display the image
        set image [image create photo -file $imagePath]
        label .csvSelect.plotImage -image $image
        pack .csvSelect.plotImage -padx 10 -pady 10
    } else {
        puts "Error in plotting CSV: $imagePath"
    }
}


# Creating the Data Upload and Viewing Window
proc createDataUploadViewWindow {} {
    set win [toplevel .dataUploadView]
    wm title $win "Data Upload and Viewing"

    # Upload Button
    button $win.upload -text "Upload CSV" -command uploadCSV
    pack $win.upload -padx 10 -pady 10

    # View Button
    button $win.view -text "View Uploaded CSV" -command selectUploadedCSVs
    pack $win.view -padx 10 -pady 10
}

# Call the function to create the window
createDataUploadViewWindow
