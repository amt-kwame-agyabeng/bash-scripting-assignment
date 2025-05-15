#!/bin/bash
# Author: Kwame Aboagye Agyabeng
# Date: 2025-05-15
# Description: This script performs backups of files and directories in a given directory.
# It provides options to perform full backups, partial backups, compress backups, and schedule backups.


  # Function to display backup menu options to the user
display_menu() {
     # Prints the menu and prompts the user for their choice
    echo "Backup Options:"
    echo "1. Full Backup"
    echo "2. Partial Backup"
    echo "3. Compress Backup"
    echo "4. Schedule Backup"
    echo "5. Exit"

}


# Function to perform full backup 
full_backup() {
    echo "Performing full backup..."
    read -p "Enter the source directory: " source_dir
    read -p "Enter the destination directory: " dest_dir
    if [ ! -d "$dest_dir" ]; then
        mkdir -p "$dest_dir"
        echo "Created destination directory: $dest_dir"
    fi
    if rsync -av "$source_dir" "$dest_dir"; then
        echo "Full backup successful!"
    else
        echo "Error: Full backup failed."
    fi
    exit 0
}

# Function to perform partial backup
partial_backup() {
    echo "Performing partial backup..."
    read -p "Enter the source directory: " source_dir
    read -p "Enter the destination directory: " dest_dir
    if [ -z "$dest_dir" ]; then
        echo "Error: Destination directory cannot be empty."
        exit 1
    fi
    if [ ! -d "$dest_dir" ]; then
        mkdir -p "$dest_dir"
        echo "Created destination directory: $dest_dir"
    fi
    # Prompt the user for the files to backup
    read -p "Enter the files to backup (comma-separated): " files
    # Perform the partial backup using rsync with the specified files and exclude the "backup" directory 
    if rsync -av --exclude="backup" --include="$files" --exclude="*" "$source_dir" "$dest_dir"; then
        echo "Partial backup successful!"
    else
        echo "Error: Partial backup failed."
    fi
    exit 0
}

# Function to perform incremental backup
compress_backup() {
    echo "Compressing backup..."
    # Prompt the user for the file to compress
    read -p "Enter the file to compress: " file

    # Prompt the user for the compression algorithm
    read -p "Enter the compression algorithm (gzip, bzip2, etc.): " algorithm

    # Perform the compression based on the algorithm
    case $algorithm in
        gzip)
            # Use gzip to compress the file
            if gzip -f "$file"; then
                echo "Compression successful!"
            else
                echo "Error: Compression failed."
            fi
            ;;
        bzip2)
            # Use bzip2 to compress the file
            if bzip2 -f "$file"; then
                echo "Compression successful!"
            else
                echo "Error: Compression failed."
            fi
            ;;
        *)
            echo "Invalid compression algorithm"
            ;;
    esac
    exit 0
}

# Function to schedule backup 
schedule_backup() {
    echo "Scheduling backup..."

    # Prompt the user for the schedule
    read -p "Enter the schedule (e.g., 0 2 * * *): " schedule

    # Prompt the user for the command to run
    read -p "Enter the command to run: " command

    # Use crontab to schedule the command to run at the specified schedule
    if echo "$schedule $command" | crontab -; then
        echo "Backup scheduled successfully!"
    else
        echo "Error: Scheduling backup failed."
    fi

    # Exit with a status of 0 to indicate success
    exit 0
}


 # Main loop to display the menu and prompt the user for their choice
while true
do
    display_menu
    read -p "Enter your choice: " choice
  
    # Check the user's choice and perform the corresponding action
    case $choice in
        1) full_backup ;;
        2) partial_backup ;;
        3) compress_backup ;;
        4) schedule_backup ;;
        5) echo "Exiting..."; exit ;;
        *) echo "Invalid choice. Please try again." ;;
    esac

    echo ""
done