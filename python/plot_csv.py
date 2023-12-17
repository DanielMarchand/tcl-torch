import matplotlib.pyplot as plt
import pandas as pd
import sys
import os

def plot_csv(file_path, output_dir):
    df = pd.read_csv(file_path)

    # Get column names
    x_col = df.columns[0]  # First column as x-axis
    y_col = df.columns[1]  # Second column as y-axis

    # Create the plot
    plt.figure()
    plt.plot(df[x_col], df[y_col])  # Plot x and y columns
    plt.xlabel(x_col)  # Label x-axis with x header
    plt.ylabel(y_col)  # Label y-axis with y header

    # Save the plot to an output file
    output_file = os.path.join(output_dir, os.path.basename(file_path) + ".png")
    plt.savefig(output_file)
    return output_file

if __name__ == "__main__":
    if len(sys.argv) > 2:
        print(plot_csv(sys.argv[1], sys.argv[2]))
