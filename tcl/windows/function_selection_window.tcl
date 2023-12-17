#!/usr/bin/env tclsh
package require Tk

# Procedures for each functionality
proc handleTestPythonInterface {} {
    puts "Test Python Interface selected."
    # Placeholder for future functionality
}

proc handleFit1DData {} {
    puts "Fit 1D Data functionality selected."
    # Placeholder for future functionality
}

proc handleFit2DData {} {
    puts "Fit 2D Data functionality selected."
    # Placeholder for future functionality
}

proc handleDefaultCase {} {
    puts "Selected functionality is not implemented yet."
    # Placeholder for unimplemented functionality
}

# Function to handle the selection of functionality
proc selectFunctionality {} {
    global selectedFunctionality

    switch -- $selectedFunctionality {
        "Test" {
            handleTestPythonInterface
        }
        "fit1D" {
            handleFit1DData
        }
        "fit2D" {
            handleFit2DData
        }
        default {
            handleDefaultCase
        }
    }
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
