#!/bin/bash
# Author: Kwame Aboagye Agyabeng
# Date: 2025-05-15
# Description: This script provides a tool to synchronize files between two folders. 
# It uses rsync to synchronize files and directories.

# Prompt user for source and target folders
read -p "Enter the source folder path: " SOURCE_FOLDER
read -p "Enter the target folder path: " TARGET_FOLDER

# Set rsync options
RSYNC_OPTIONS="-avz --delete --update"

# Function to synchronize files from source to target
sync_source_to_target() {
  rsync $RSYNC_OPTIONS $SOURCE_FOLDER/ $TARGET_FOLDER/
}

# Function to synchronize files from target to source
sync_target_to_source() {
  rsync $RSYNC_OPTIONS $TARGET_FOLDER/ $SOURCE_FOLDER/
}

# Function to handle conflicts
handle_conflicts() {
  # Check for conflicts (files with same name but different content)
  conflicts=$(rsync -avn --delete --update $SOURCE_FOLDER/ $TARGET_FOLDER/ | grep "f.cT")

  # Handle conflicts by overwriting target file with source file
  if [ -n "$conflicts" ]; then
    rsync $RSYNC_OPTIONS --ignore-existing $SOURCE_FOLDER/ $TARGET_FOLDER/
  fi
}

# Main loop
while true
do
  sync_source_to_target
  sync_target_to_source
  handle_conflicts
  sleep 1
done