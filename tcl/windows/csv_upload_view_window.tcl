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



