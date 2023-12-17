#!/usr/bin/env tclsh

package require Tk
package require tcl-torch

# Function to open the function selection window
proc openFunctionSelectionWindow {} {
    source "frontend/windows/function_selection_window.tcl"
    destroy .mainWindow  ;# Close the main window

}

# Function to create the main window
proc createMainWindow {} {
    set mainWindow [toplevel .mainWindow]  ;# Provide a unique name for the main window
    wm title $mainWindow "PyTorch-Tcl Data Analysis App"

    # Load and display the logo
    set logoImage [image create photo -file "resources/logo.png"]
    label $mainWindow.logo -image $logoImage
    pack $mainWindow.logo -padx 20 -pady 20

    # Create and pack the start button
    button $mainWindow.startBtn -text "Start Program" -command openFunctionSelectionWindow
    pack $mainWindow.startBtn -padx 20 -pady 10

    # Additional setup for the main window can go here...
    #destroy . 
}

# Main execution
createMainWindow
vwait forever
