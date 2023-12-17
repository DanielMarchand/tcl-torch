# Get the directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Set the TCLLIBPATH environment variable using the script's directory
export TCLLIBPATH="$DIR $TCLLIBPATH"
