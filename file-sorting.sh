#!/bin/bash
# Author: Kwame Aboagye Agyabeng
# Date: 2023-03-08
# Description: This script sorts files in the current directory into categories based on their extensions.
# Usage: Run the script in the directory containing the files to be sorted.
# The script is run with root privileges


if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

# Define file categories and their corresponding extensions
categories=(
    "Images:jpg,jpeg,png,gif,bmp"
    "Documents:doc,docx,pdf,txt"
    "Videos:mp4,mov,avi"
    "Music:mp3,wav,ogg"
    "Archives:zip,tar.gz,7z"
    "Executables:exe,dll"
    "Scripts:sh,py,js"
    "Web:html,css,js"
    "Other:"
)

# function to sort files into categories based on their extensions 
sort_files() {
    # loop through all files in the current directory
    for file in *; do
    # skip the script file itself
        if [ "$file" == "file-sorting.sh" ]; then
            continue
        fi
    # get the file extension
        if [ -f "$file" ]; then
            extension="${file##*.}"
            moved=false
            # loop through all categories
            for category in "${categories[@]}"; do
                category_name="${category%%:*}"
                category_extensions="${category#*:}"
                # check if the file extension is in the category's extensions
                if [[ ",$category_extensions," == *",$extension,"* ]]; then
                    if [ ! -d "$category_name" ]; then
                        mkdir "$category_name"
                    fi
                    mv "$file" "$category_name/"
                    echo "Moved $file to $category_name"
                    moved=true
                    break
                fi
            done
            # if no category match, move to Other
            if [ $moved = false ]; then
                if [ ! -d "Other" ]; then
                    mkdir "Other"
                fi
                mv "$file" "Other/"
                echo "Moved $file to Other"
            fi
        fi
    done
}

# call the function to sort files
sort_files