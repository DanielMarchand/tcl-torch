#!/usr/bin/env tclsh

package require Tk
package require Img

# Function to open the function selection window
proc openFunctionSelectionWindow {} {
    # Include the code to open or source function_selection_window.tcl
    # For example:
    # source "windows/function_selection_window.tcl"
}

# Function to setup the main window
proc setupMainWindow {} {
    wm title . "PyTorch-Tcl Data Analysis App"

    # Load and resize the logo
    set logoImage [image create photo -file "resources/logo.png"]
    $logoImage copy $logoImage -subsample 4 4  # Adjust subsample rate as needed
    label .logo -image $logoImage
    pack .logo -padx 20 -pady 20

    # Create and pack the start button
    button .startBtn -text "Start Program" -command openFunctionSelectionWindow
    pack .startBtn -padx 20 -pady 10
}

# Main execution
setupMainWindow
vwait forever
