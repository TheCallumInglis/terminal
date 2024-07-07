#!/bin/sh

archiveFile() {
    backup_filename=".vimrc-backup-$(date +%s)"

    echo "\r\nArchiving ~/.vimrc."
    cp ~/.vimrc ~/$backup_filename
    echo "Archived ~/.vimrc to ~/$backup_filename."
}

createSymlink() {
    symlink_path="$(pwd)/.vimrc"
    
    echo "\r\nCreating a symlink from ~/.vimrc to $symlink_path"
    ln -s $symlink_path ~/.vimrc
    echo "Symlink created from $symlink_path to ~/.vimrc."
}

if [ -f ~/.vimrc ]; then
    echo "The ~/.vimrc file exists.\r\n"

    echo "What would you like to do?"

    echo "1) Archive existing and replace with new"
    echo "2) Cancel the operation\r\n"

    read -p "Enter your choice: " choice

    case $choice in
        1)
            # Archive the file & Replace With Symlink
            archiveFile
            createSymlink
            ;;
        2)
            # Cancel the operation
            echo "Operation cancelled."
            exit 0
            ;;
        *)
            echo "Invalid choice. Operation cancelled."
            exit 0
            ;;
    esac
else 
    createSymlink
fi

echo "\r\nInstallation complete."
echo "Please restart your terminal to see the changes."
exit