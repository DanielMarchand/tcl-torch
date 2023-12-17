import sys
import pandas as pd
import os

def save_and_validate_csv(input_path, output_dir):
    try:
        # Read CSV
        df = pd.read_csv(input_path)

        # Validate - check if there are exactly two columns
        if df.shape[1] != 2:
            raise ValueError("CSV file must have exactly two columns")

        # Save CSV to the standard location
        output_path = os.path.join(output_dir, os.path.basename(input_path))
        df.to_csv(output_path, index=False)
        return f"CSV saved and validated: {output_path}"

    except Exception as e:
        return f"Error: {str(e)}"

if __name__ == "__main__":
    if len(sys.argv) > 2:
        print(save_and_validate_csv(sys.argv[1], sys.argv[2]))
