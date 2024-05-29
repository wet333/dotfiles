function vsdocs() {
    directory="$HOME/Documents"

    # Check if code command is available
    if ! command -v code &> /dev/null; then
        echo "Visual Studio Code is not installed or not in PATH."
        return 1
    fi

    # Open ~/Documents directory with Visual Studio Code
    code "$directory"
}

function vsdot() {

    directory="$HOME/dotfiles"

    # Check if code command is available
    if ! command -v code &> /dev/null; then
        echo "Visual Studio Code is not installed or not in PATH."
        return 1
    fi

    # Open ~/dotfiles directory with Visual Studio Code
    code "$directory"
}