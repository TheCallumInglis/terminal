#!/bin/zsh

getTimestamp() {
    date +"%Y%m%dT%H%M%S"
}

replaceWithSymlink() {
    echo "\r\nReplacing ~/.zshrc with a symlink."
    rm ~/.zshrc
    createSymlink
}

createSymlink() {
    symlink_path="$(pwd)/.zshrc"
    
    echo "\r\nCreating a symlink from ~/.zshrc to $symlink_path"
    ln -s $symlink_path ~/.zshrc
    echo "Symlink created from $symlink_path to ~/.zshrc."

    reload
}

reload() {
    source ~/.zshrc
    echo "Reloaded ~/.zshrc."
}

setupPlugins() {
    echo "\r\nSetting up plugins."

    # plugin_dir=~/.oh-my-zsh/custom/plugins/
    # mkdir -p $plugin_dir

    # Auto Suggestions
    # git clone https://github.com/zsh-users/zsh-autosuggestions $plugin_dir/zsh-autosuggestions
    brew install --quiet zsh-autosuggestions

    # Syntax Highlighting
    # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $plugin_dir/zsh-syntax-highlighting
    brew install --quiet zsh-syntax-highlighting

    # Z (First check if it exists)
    if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z/" ]; then
        git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
    fi

    reload
}

archiveFile() {
    backup_filename=".zshrc-backup-$(getTimestamp)"

    echo "\r\nArchiving ~/.zshrc."
    cp ~/.zshrc ~/$backup_filename
    echo "Archived ~/.zshrc to ~/$backup_filename."
}

echo "oh-my-zsh install script\r\n"

# Check if ~/.zshrc exists
if [ -f ~/.zshrc ]; then
    echo "The ~/.zshrc file exists.\r\n"
    echo "What would you like to do?"
    echo "1) Replace the file with a symlink"
    echo "2) Archive exiting and replace with new"
    echo "3) Cancel the operation\r\n"
    read "choice?Enter your choice (1, 2, or 3): " 

    case $choice in
        1)
            # Replace the file with a symlink
            replaceWithSymlink
            setupPlugins
            ;;
        2)
            # Archive the file & Replace With Symlink
            archiveFile
            replaceWithSymlink
            setupPlugins
            ;;
        3)
            # Cancel the operation
            echo "Operation cancelled."
            exit
            ;;
        *)
            echo "Invalid choice. Operation cancelled."
            exit
            ;;
    esac
else
    # Create a symlink
    createSymlink
    setupPlugins
fi

echo "\r\nInstallation complete."
echo "Please restart your terminal to see the changes."
exit
