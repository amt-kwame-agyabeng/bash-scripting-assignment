#!/bin/bash
# Author: Kwame Aboagye Agyabeng
# Date: 2025-05-15
# Description: This script renames files in the current directory based on a specified pattern.
# Usage: Run the script in the directory containing the files to be renamed.

# Prompt the user for the directory containing the files to rename
echo "Enter the directory containing the files to rename:"
read directory

# Prompt the user for the naming convention
echo "Enter the naming convention (e.g. 'file_%d.txt' for a counter-based naming convention):"
read naming_convention

# Prompt the user for the prefix
echo "Enter the prefix to add to the filenames (e.g. 'prefix_' or leave blank for no prefix):"
read prefix

# Prompt the user for the suffix 
echo "Enter the suffix to add to the filenames (e.g. '_suffix' or leave blank for no suffix):"
read suffix

# Prompt the user for the counter start value 
echo "Enter the starting value for the counter (leave blank for no counter):"
read counter_start

# Prompt the user for the date format to use in the filenames
echo "Enter the date format to use in the filenames (eg. '%Y%m%d' or leave blank for no date):"
read date_format

# Initialize the counter variable to the starting value if provided by the user
counter=$counter_start

# Loop through each file in the directory
for file in "$directory"/*; do
  # Get the file extension
  file_extension=${file##*.}

  # Get the file name without extension
  file_name=${file%.*}

  # Apply the naming convention
  if [ -n "$naming_convention" ]; then
    if [[ $naming_convention =~ %d ]]; then
      new_name=$(printf "$naming_convention" $counter)
    else
      new_name=$naming_convention
    fi
  else
    new_name=$file_name
  fi

  # Add the prefix, suffix, and date
  new_name=$new_name$prefix$suffix$(date +"$date_format").$file_extension

  # Rename the file
  mv "$file" "$directory/$new_name"

  # Increment the counter
  if [ -n "$counter_start" ]; then
    ((counter++))
  fi
done

echo "File renaming completed."
# print out the new file names
echo "New file names:"
ls "$directory"



