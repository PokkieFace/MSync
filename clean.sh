#!/bin/bash

# Directory to process - change this to your directory path
TARGET_DIR="./Mega-Sync"

# Function to sanitize a filename
sanitize_filename() {
    local name="$1"
    
    # Remove emojis and other non-ASCII characters
    name=$(echo "$name" | tr -cd '\000-\177')
    
    # Replace spaces with underscores
    name=$(echo "$name" | tr ' ' '_')
    
    # Remove other problematic characters (except alphanumeric, underscore, hyphen, period)
    name=$(echo "$name" | sed 's/[^a-zA-Z0-9_\-\.]//g')
    
    # If name became empty, provide a default
    if [ -z "$name" ]; then
        name="renamed_file"
    fi
    
    echo "$name"
}

# Process all files recursively
find "$TARGET_DIR" -type f | while read -r file; do
    dir=$(dirname "$file")
    filename=$(basename "$file")
    extension="${filename##*.}"
    basename="${filename%.*}"
    
    # Sanitize the basename
    new_basename=$(sanitize_filename "$basename")
    
    # Only rename if the name changed
    if [ "$basename" != "$new_basename" ]; then
        new_filename="${new_basename}.${extension}"
        new_path="${dir}/${new_filename}"
        
        # Rename the file
        echo "Renaming: $filename → $new_filename"
        mv "$file" "$new_path"
    fi
done

# Process directory names (from deepest to shallowest to avoid path issues)
find "$TARGET_DIR" -type d -depth | while read -r dir; do
    # Skip the target directory itself
    if [ "$dir" == "$TARGET_DIR" ]; then
        continue
    fi
    
    parent_dir=$(dirname "$dir")
    dirname=$(basename "$dir")
    
    # Sanitize the directory name
    new_dirname=$(sanitize_filename "$dirname")
    
    # Only rename if the name changed
    if [ "$dirname" != "$new_dirname" ]; then
        new_path="${parent_dir}/${new_dirname}"
        
        # Rename the directory
        echo "Renaming directory: $dirname → $new_dirname"
        mv "$dir" "$new_path"
    fi
done

echo "File renaming process completed!"
