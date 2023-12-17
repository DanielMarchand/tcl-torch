import os
import sys

def check_packages(requirements_file):
    script_directory = os.path.dirname(os.path.abspath(__file__))  # Get the directory of the script
    requirements_path = os.path.join(script_directory, requirements_file)

    try:
        with open(requirements_path, 'r') as file:
            for line in file:
                line = line.strip()
                if line:  # Check if the line is not empty
                    package = line.split('==')[0]  # Assumes format package==version
                    try:
                        __import__(package)
                        print(f"Package '{package}' is available.")
                    except ImportError:
                        print(f"Missing package: {package}")
        print("All dependencies have been checked.")
    except FileNotFoundError:
        print(f"requirements.txt file not found at {requirements_path}")

if __name__ == "__main__":
    requirements_file = '../../python/requirements.txt'  # Now it's located in the same directory as the script
    check_packages(requirements_file)

