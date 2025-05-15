#!/bin/bash
# Author: Kwame Aboagye Agyabeng
# Date: 2025-05-15
# Description: This script provides a tool to encrypt and decrypt files.


# Function to encrypt a file
encrypt_file() {
  local file=$1
  local password=$2

  # Generate a random salt
  local salt=$(openssl rand -hex 16)

  # Generate a key from the password and salt
  local key=$(echo -n "$password" | openssl dgst -sha256 -hmac "$salt" -binary)

  # Encrypt the file
  openssl enc -aes-256-cbc -pbkdf2 -iter 10000 -pass pass:$password -in $1 -out ${1}.enc
  rm $1
}

# Function to decrypt a file
decrypt_file() {
  local file=$1
  local password=$2
  openssl enc -d -aes-256-cbc -pbkdf2 -pass pass:$password -in $1 -out ${1%.enc}
  rm $1
}


main() {

  if [ $# -ne 3 ]; then
    echo "Usage: $0 <encrypt|decrypt> <file> <password>"
    exit 1
  fi

  local action=$1
  local file=$2
  local password=$3

  if [ "$action" = "encrypt" ]; then
    encrypt_file "$file" "$password"
  elif [ "$action" = "decrypt" ]; then
    if [[ $file == *.enc ]]; then
      decrypt_file "$file" "$password"
    else
      echo "Error: Decryption requires the encrypted file name (with .enc extension)"
      exit 1
    fi
  else
    echo "Invalid action. Please use 'encrypt' or 'decrypt'."
    exit 1
  fi
}

main "$@"