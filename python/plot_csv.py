import matplotlib.pyplot as plt
import pandas as pd
import sys
import os

def plot_csv(file_path, output_dir):
    df = pd.read_csv(file_path)

    # Get column names
    x_col = df.columns[0]  # First column as x-axis

    # Create the plot
    plt.figure()
    for y_col in df.columns[1:]:  # Loop through all columns except the first
        plt.plot(df[x_col], df[y_col], label=y_col)  # Plot each column against the first column

    plt.xlabel(x_col)  # Label x-axis with the first column header
    plt.legend()  # Add a legend

    # Save the plot to an output file
    output_file = os.path.join(output_dir, os.path.splitext(os.path.basename(file_path))[0] + "_plot.png")
    plt.savefig(output_file)
    plt.close()  # Close the plot to free memory
    return output_file

if __name__ == "__main__":
    if len(sys.argv) > 2:
        print(plot_csv(sys.argv[1], sys.argv[2]))
