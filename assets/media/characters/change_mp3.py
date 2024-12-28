import os
import shutil

# Base directory where the folders are located
base_dir = r"D:/work/Flutter/yosrixia/assets/media/characters"

# List of folders to process
folders = [
    'alef', 'ba', 'ta', 'tha', 'jeem', 'ha', 'kha', 'dal', 'dhal', 
    'ra', 'za', 'seen', 'sheen', 'sad', 'dad', 'taa', 'zaa', 'ain', 
    'ghain', 'fa', 'qaf', 'kaf', 'lam', 'meem', 'noon', 'haa', 'waw', 'ya'
]

# Iterate through each base folder in the list
for folder in folders:
    # Base folder path (e.g., alef, ba, etc.)
    base_folder_path = os.path.join(base_dir, folder)

    # List of subfolder suffixes to check (e.g., 'alef2', 'alef3', 'alef4')
    subfolder_suffixes = ['2', '3', '4']  # Modify if you have more subfolders like '5', etc.

    # Iterate through the subfolder suffixes
    for suffix in subfolder_suffixes:
        subfolder_name = f"{folder}{suffix}"
        subfolder_path = os.path.join(base_dir, subfolder_name)

        if os.path.exists(subfolder_path):
            # Move files from the subfolder to the base folder
            for file in os.listdir(subfolder_path):
                file_path = os.path.join(subfolder_path, file)
                if os.path.isfile(file_path):
                    target_path = os.path.join(base_folder_path, file)
                    shutil.move(file_path, target_path)
                    print(f"Moved {file} from {subfolder_name} to {folder}")

            # Remove the empty subfolder
            os.rmdir(subfolder_path)
            print(f"Removed empty folder: {subfolder_name}")
