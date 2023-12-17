# Procedures to handle calling Python scripts and processing their outputs

proc executePythonScript {scriptPath args} {
    global pythonExecutable
    set fullCommand [concat $pythonExecutable $scriptPath {*}$args]
    set output [exec {*}$fullCommand]
    return $output
}

