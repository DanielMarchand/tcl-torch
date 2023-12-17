#!/usr/bin/env tclsh
package require Tk

# Declare a global variable for selected functionality
variable selectedFunctionality

# Function to handle the selection of functionality
proc selectFunctionality {} {
    global selectedFunctionality

    # Handle the selected functionality
    puts "Selected functionality: $selectedFunctionality"
    # Here, add the specific action based on the selected functionality
}

# Create the Function Selection Window
proc createFunctionSelectionWindow {} {
    global selectedFunctionality

    # Create the top-level window
    set functionSelectionWindow [toplevel .function_selection]
    wm title $functionSelectionWindow "Function Selection"

    # Initialize the selected functionality variable
    set selectedFunctionality "fit1D" ; # Default selection

    # Create radio buttons for functionality selection
    radiobutton $functionSelectionWindow.test -text "Testing Python Interface" \
        -variable selectedFunctionality -value "Test"
    radiobutton $functionSelectionWindow.fit1D -text "Fit 1D Data" \
        -variable selectedFunctionality -value "fit1D"
    radiobutton $functionSelectionWindow.fit2D -text "Fit 2D Data (Coming Soon!)" \
        -variable selectedFunctionality -value "fit2D" -state disabled

    # Create and pack the select button
    button $functionSelectionWindow.selectButton -text "Select" -command selectFunctionality
    pack $functionSelectionWindow.test -anchor w
    pack $functionSelectionWindow.fit1D -anchor w
    pack $functionSelectionWindow.fit2D -anchor w
    pack $functionSelectionWindow.selectButton
}

# Call the function to create the Function Selection Window
createFunctionSelectionWindow
