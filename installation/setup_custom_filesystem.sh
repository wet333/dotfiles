#!/bin/bash

# Functions ------------------------------------------------------------------------------------------------------------

create_scaffold() {
  # Check if at least the root directory is provided
  if [ "$#" -lt 1 ]; then
    echo "Usage: create_scaffold <root_directory> <path1> [path2] ..."
    echo "Error: Root directory argument is missing."
    return 1 # Return with error code
  fi

  local root_dir="$1"
  shift # Remove the root directory from the arguments list

  # Check if at least one path to create is provided
  if [ "$#" -lt 1 ]; then
    echo "Usage: create_scaffold <root_directory> <path1> [path2] ..."
    echo "Error: At least one path must be provided."
    return 1 # Return with error code
  fi

  echo "Creating scaffold under root: '$root_dir'"

  # Loop through the remaining arguments (the paths to create)
  local path_to_create
  for path_to_create in "$@"; do

    # Construct the full path
    local full_path="$root_dir/$path_to_create"

    # Create the directory, including any necessary parent directories (-p)
    if mkdir -p -v "$full_path"; then
      echo "Created: $full_path"
    else
      echo "Error: Failed to create '$full_path'" >&2
    fi
  done

  echo "Scaffold creation complete."
  return 0 # Return success
}

delete_scaffold() {
  # Check if at least the root directory is provided
  if [ "$#" -lt 1 ]; then
    echo "Usage: delete_scaffold <root_directory> <path1> [path2] ..."
    echo "Error: Root directory argument is missing."
    return 1
  fi

  local root_dir="$1"
  # Basic safety check: ensure root_dir is not empty or '/'
  if [[ -z "$root_dir" || "$root_dir" == "/" ]]; then
      echo "Error: Root directory is empty or '/'. Deletion aborted for safety." >&2
      return 1
  fi
  # Ensure the root directory actually exists before trying to delete within it
  if [[ ! -d "$root_dir" ]]; then
      echo "Warning: Root directory '$root_dir' does not exist. Nothing to delete within it." >&2
      # You might choose to return 0 here if this isn't considered an error
      return 0 
  fi

  shift # Remove the root directory from the arguments list

  # Check if at least one path to delete is provided
  if [ "$#" -lt 1 ]; then
    echo "Usage: delete_scaffold <root_directory> <path1> [path2] ..."
    echo "Error: At least one path to delete must be specified."
    return 1
  fi

  echo "Deleting scaffold under root: '$root_dir'"
  echo "WARNING: This will permanently delete specified directories and their contents!"

  # Confirmation prompt
  read -p "Are you sure you want to continue? (y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || return 1

  local path_to_delete
  for path_to_delete in "$@"; do
    # Construct the full path
    local full_path="$root_dir/$path_to_delete"

    # More safety checks: ensure the constructed path is not empty or '/'
    if [[ -z "$full_path" || "$full_path" == "/" || "$full_path" == "$root_dir" ]]; then
        echo "Error: Attempting to delete empty path, '/', or the root '$root_dir' itself ('$path_to_delete'). Skipping." >&2
        continue
    fi

    # Check if the target directory actually exists before trying to delete
    if [ -d "$full_path" ]; then
      # Delete the directory recursively (-r) and forcefully (-f, suppresses prompts)
      echo "Attempting to delete: $full_path"

      if rm -r -v "$full_path"; then
        echo "Deleted: $full_path"
        :
      else
        echo "Error: Failed to delete '$full_path'" >&2
      fi
    else
      echo "Warning: Directory '$full_path' does not exist. Skipping." >&2
    fi
  done

  echo "Scaffold deletion complete."
  return 0
}

# ----------------------- Main Script Execution -------------------------------

# Base directory
home_dir="$HOME"

# List of directories to delete
declare -a dirs_to_delete=(
    "None"
)

# List of directories to create
declare -a dirs_to_create=(
    "Programming/Assembly"
    "Programming/Java"
    "Programming/C"
    "Programming/Linux"
    "Programming/Python"
    "Pictures/Photos"
    "Pictures/Images"
    "Pictures/Wallpapers"
    "Videos"
    "Music"
    "Maker/3DPrinting"
    "Maker/Electronics"
    "Documents/Notes"
)

# Delete directories
delete_scaffold "$home_dir" "${dirs_to_delete[@]}"

# Create directories
create_scaffold "$home_dir" "${dirs_to_create[@]}"