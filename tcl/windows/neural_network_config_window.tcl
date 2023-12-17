package require Tk
package require TclTorch


# Procedure to create the Neural Network Configuration Window
proc createNNConfigWindow {} {
    variable nnConfig
    variable modelName "your_model_name"

    # Initialize the associative array with default values
    set nnConfig(neuronsPerLayer) 20
    set nnConfig(numLayers) 2
    set nnConfig(numNetworks) 5
    set nnConfig(learningRate) 1e-4
    set nnConfig(epochs) 500
    set nnConfig(logInterval) 100

    set nnConfigWindow [toplevel .nnConfig]
    wm title $nnConfigWindow "Neural Network Configuration"

    # Create widgets for each configuration option and bind them to the associative array
    label $nnConfigWindow.neuronsLbl -text "Neurons Per Layer:"
    entry $nnConfigWindow.neuronsEntry -textvariable nnConfig(neuronsPerLayer)

    label $nnConfigWindow.layersLbl -text "Number of Layers:"
    entry $nnConfigWindow.layersEntry -textvariable nnConfig(numLayers)

    label $nnConfigWindow.networksLbl -text "Number of Networks:"
    entry $nnConfigWindow.networksEntry -textvariable nnConfig(numNetworks)

    label $nnConfigWindow.lrLbl -text "Learning Rate:"
    entry $nnConfigWindow.lrEntry -textvariable nnConfig(learningRate)

    label $nnConfigWindow.epochsLbl -text "Epochs:"
    entry $nnConfigWindow.epochsEntry -textvariable nnConfig(epochs)

    label $nnConfigWindow.logLbl -text "Log Interval:"
    entry $nnConfigWindow.logEntry -textvariable nnConfig(logInterval)

    label $nnConfigWindow.modelNameLbl -text "Model Name:"
    entry $nnConfigWindow.modelNameEntry -textvariable modelName

    # GPU Usage (Radio Button)
    label $nnConfigWindow.gpuLbl -text "Use GPU:"
    radiobutton $nnConfigWindow.gpuYes -text "Yes" -state disabled -value True
    radiobutton $nnConfigWindow.gpuNo -text "No" -value False

    # Store Model Button
    button $nnConfigWindow.storeModelBtn -text "Store Model" -command [list storeModel $nnConfigWindow]

    # Arrange widgets using grid
    grid $nnConfigWindow.neuronsLbl $nnConfigWindow.neuronsEntry
    grid $nnConfigWindow.layersLbl $nnConfigWindow.layersEntry
    grid $nnConfigWindow.networksLbl $nnConfigWindow.networksEntry
    grid $nnConfigWindow.lrLbl $nnConfigWindow.lrEntry
    grid $nnConfigWindow.epochsLbl $nnConfigWindow.epochsEntry
    grid $nnConfigWindow.logLbl $nnConfigWindow.logEntry
    grid $nnConfigWindow.modelNameLbl $nnConfigWindow.modelNameEntry
    grid $nnConfigWindow.gpuLbl $nnConfigWindow.gpuYes $nnConfigWindow.gpuNo
    grid $nnConfigWindow.storeModelBtn
}

