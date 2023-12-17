package provide TclTorch 0.1
# config.tcl

# Set the root directory of the tcl files 
namespace eval TclTorch {
    variable tclRoot [file dirname [info script]]

    source ${tclRoot}/config.tcl
    source ${tclRoot}/interface/python_interface.tcl
    source ${tclRoot}/utils/temp_dirs.tcl
    source ${tclRoot}/utils/json.tcl

    
}

