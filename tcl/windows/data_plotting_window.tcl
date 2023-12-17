package require Tk
package require TclTorch

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
