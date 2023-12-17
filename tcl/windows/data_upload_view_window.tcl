package require Tk

# Procedure to open a file dialog and upload a CSV file
proc uploadCSV {} {
    # Use tk_getOpenFile to let the user select a CSV file
    set filename [tk_getOpenFile -filetypes {{"CSV Files" ".csv"}}]
    if {$filename != ""} {
        # You can call a Python script to handle the CSV file here
        # Example: TclTorch::execPython "path/to/csv_handler.py" $filename
        puts "CSV file selected: $filename"
    }
}

# Procedure to handle viewing previously uploaded CSV/models
proc viewUploadedCSVs {} {
    # Implement the logic to view previously uploaded CSVs or models
    puts "Viewing uploaded CSVs/models"
}

# Creating the Data Upload and Viewing Window
proc createDataUploadViewWindow {} {
    set win [toplevel .dataUploadView]
    wm title $win "Data Upload and Viewing"

    # Upload Button
    button $win.upload -text "Upload CSV" -command uploadCSV
    pack $win.upload -padx 10 -pady 10

    # View Button
    button $win.view -text "View Uploaded CSV/Models" -command viewUploadedCSVs
    pack $win.view -padx 10 -pady 10
}

# Call the function to create the window
createDataUploadViewWindow
