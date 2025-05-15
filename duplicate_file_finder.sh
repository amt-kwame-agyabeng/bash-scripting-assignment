#!/bin/bash

# Prompt the user for the directory to search for duplicates
echo "Enter the directory to search for duplicates:"
read directory

# Create an array to store the file hashes
declare -A file_hashes

# Loop through each file in the directory
for file in "$directory"/*; do
  # Check if the current item is a file
  if [ -f "$file" ]; then
    # Get the file size
    file_size=$(stat -c%s "$file")

    # Get the file hash
    file_hash=$(md5sum "$file" | cut -d' ' -f1)

    # Check if the file hash is already in the array
    if [[ ${file_hashes[$file_hash]} ]]; then
      # If the file hash is already in the array, add the file to the list of duplicates
      file_hashes[$file_hash]+=" $file"
    else
      # If the file hash is not in the array, add it with the file as the first duplicate
      file_hashes[$file_hash]=$file
    fi
  fi
done

# Loop through the file hashes and print the duplicates
for file_hash in "${!file_hashes[@]}"; do
  # Get the list of duplicates for this file hash
  duplicates=${file_hashes[$file_hash]}

  # If there is more than one duplicate, print the list
  if [[ $duplicates =~ \  ]]; then
    echo "Duplicates found:"
    echo "$duplicates"
    echo ""

    # Offer choices to delete or move the duplicates
    echo "What would you like to do with these duplicates?"
    echo "1. Delete all duplicates"
    echo "2. Move all duplicates to a new directory"
    echo "3. Do nothing"

    read choice

    case $choice in
      1)
        # Delete all duplicates
        for file in $duplicates; do
          rm "$file"
        done
        echo "Duplicates deleted."
        ;;
      2)
        # Move all duplicates to a new directory
        mkdir -p "$directory/duplicates"
        for file in $duplicates; do
          mv "$file" "$directory/duplicates/"
        done
        echo "Duplicates moved to $directory/duplicates."
        ;;
      3)
        # No action taken
        ;;
      *)
        echo "Invalid choice."
        ;;
    esac
  fi
done