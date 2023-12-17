package provide TclTorch 0.1
# config.tcl

# Set the path to the Python executable
set pythonExecutable "python3"

# Set the root directory of the tcl files 
namespace eval ::TclTorch {
    variable tclRoot [file dirname [info script]]
    namespace export tclRoot
}
# Set the root directory of the project (one directory higher)
namespace eval ::TclTorch {
    variable projectRoot [file dirname [file dirname [info script]]]
    namespace export projectRoot
}
