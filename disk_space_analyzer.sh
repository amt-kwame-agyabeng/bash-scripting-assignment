#!/bin/bash
# Author: Kwame Aboagye Agyabeng
# Date: 2025-05-15
# Description: This script provides a tool to analyze disk space usage in a directory.


# Function to display disk usage of a given directory
get_disk_usage() {
  
   #   $1 - path: Directory path to analyze
  local path=$1
   #   $2 - sort_by: Criterion to sort the output (e.g., "size" or "name")
  local sort_by=$2
   #   $3 - filter_size: Minimum size in MB to filter the results
  local filter_size=$3

  # Check the sorting criteria and execute the appropriate command
  if [ "$sort_by" = "size" ]; then
    # Sort by size in descending order
    tree -a -d --du "$path" | sort -rn -k 2
  elif [ "$sort_by" = "name" ]; then
    # Sort by name in ascending order
    tree -a -d --du "$path" | sort
  else
    # Display unsorted disk usage
    tree -a -d --du "$path"
  fi

  # Filter results by minimum size if specified
  if [ -n "$filter_size" ]; then
    awk -v filter_size="$filter_size" '$2 >= filter_size {print $0}'
  fi
}


# Main function  
main() {
  path="."
  while true; do
    echo "Disk Usage Tool"
    echo "1. Print disk usage"
    echo "2. Sort by size"
    echo "3. Sort by name"
    echo "4. Filter by size"
    echo "5. Quit"

    read -p "Choose an option: " choice

    case $choice in
      1) get_disk_usage "$path";;
      2) get_disk_usage "$path" "size";;
      3) get_disk_usage "$path" "name";;
      4) read -p "Enter minimum size in MB: " filter_size; get_disk_usage "$path" "" "$filter_size";;
      5) exit 0;;
      *) echo "Invalid choice. Please try again.";;
    esac
  done
}

main