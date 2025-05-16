## Overview
This repository contains a collection of Bash scripts designed to automate common file management, backup, encryption, and system tasks. Each script is self-contained and user-friendly with prompts or command-line argument usage.

---

## Scripts Overview

### 1. Automatic File Sorter (`file-sorting.sh`)
- **Description**: Sorts files in a specified directory by type (e.g., images, documents , videos, music, archives, executables, scripts web and others) and moves them into separate folders.

**Features:**
- Sorts files by type
- Moves files to designated folders
- Supports various file types
- User-friendly with interactive prompts

**Usage:** 
Run script in a specific directory where you want your files to be sorted in categories.


**Run:**
To run the script you use this command:

```bash
./file-sorting.sh

```


### 2. Bulk File Renamer (`bulk_file_renamer.sh`)

**Description:**  
Renames files in a specified directory based on user-defined naming conventions including prefixes, suffixes, counters, and date formatting.

**Features:**  
- Supports custom naming patterns (with counters)  
- Add optional prefix, suffix, and date (with format)  
- Applies renaming to all files in the target directory  

**Usage:**  
Run the script and provide the directory, naming convention, prefix, suffix, counter start, and date format when prompted.



**Run:**
To run the script you use this command:

```bash
./bulk_file_renamer.sh

```

### 3. Duplicate File Finder (`duplicate_file_finder.sh`)

**Description:**  
Detects duplicate files within a directory by comparing file hashes (MD5). Offers options to delete or move duplicates.

**Features:**  
- Root privilege required for file operations  
- Identifies duplicates by file content (hash comparison)  
- User choice to delete or move duplicates to a subdirectory  

**Usage:**  
Run the script as root and enter the directory path when prompted.

**Run:**
To run the script you use this command:

```bash
./duplicate_file_finder.sh

```




### 4. File Backup System (`file_backup.sh`)

**Description:**  
Provides full or partial backup solutions, with options to compress backups and schedule backup jobs via `cron`.

**Features:**  
- Full backup of directories via `rsync`  
- Partial backup with user-specified files  
- Compression support (`gzip`, `bzip2`)  
- Scheduling backups using `crontab`  

**Usage:**  
Run the script and select options from the menu to perform backups or schedule jobs.

**Run:**
To run the script you use this command:

```bash
./file_backup.sh

```


### 5. Disk Space Analyzer (`disk_space_analyzer.sh`)

**Description:**  
Analyzes and reports disk usage in a directory with sorting (by size or name) and filtering by minimum size.

**Features:**  
- Uses `tree` command with disk usage summary  
- Sort output by size (descending) or name (ascending)  
- Filter results by minimum size threshold  

**Usage:**  
Run the script and choose options from the menu to analyze disk usage.

**Run:**
To run the script you use this command:

```bash
./disk_space_analyzer.sh

```

### 6. File Encryption Tool (`file_encrption_tool.sh`)

**Description:**  
Encrypts or decrypts files using AES-256-CBC with password protection via OpenSSL.

**Features:**  
- Password-based encryption with PBKDF2 key derivation  
- Encrypts files and appends `.enc` extension  
- Decrypts only files with `.enc` extension  

**Usage:**  


**Run:**
To run the script you use this command:
```bash
./file-crypto.sh <encrypt|decrypt> <file> <password>

```

### 7. File Sync Utility (`file_sync_utility.sh`)

**Description:**  
Synchronizes files between two folders bidirectionally using `rsync`. It keeps both folders updated by syncing changes from source to target and vice versa, with conflict handling.

**Features:**  
- Bidirectional sync with `rsync` options `-avz --delete --update`  
- Conflict detection and resolution (overwrites target with source)  
- Continuous sync loop with 1-second intervals  

**Usage:**  
Run the script and provide source and target folder paths when prompted.

**Run:**
To run the script you use this command:

```bash
./file-renamer.sh

```
