#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to print error message and exit
error_exit() {
    echo "Error: $1" >&2
    exit 1
}

# Check if GOPATH is set
if [ -z "$GOPATH" ]; then
    error_exit "GOPATH is not set. Please set your GOPATH environment variable."
fi

echo "GOPATH is set to: $GOPATH"

# Check if go command is available
if ! command_exists go; then
    error_exit "Go is not installed. Please install Go first."
fi

# Array of required Go packages
go_packages=(
    "github.com/incu6us/goimports-reviser/v3"
    "github.com/segmentio/golines"
)

# Check and install Go packages
for package in "${go_packages[@]}"; do
    if ! test -d "$GOPATH/pkg/mod/$package"; then
        echo "Installing $package..."
        go install "$package@latest" || error_exit "Failed to install $package"
    else
        echo "$package is already installed"
    fi
done

# Check if pip is installed
if ! command_exists pip; then
    error_exit "pip is not installed. Please install pip first."
fi

# Check if requirements.txt exists
if [ ! -f "requirements.txt" ]; then
    error_exit "requirements.txt file not found"
fi

# Get list of installed packages
installed_packages=$(pip freeze)

# Read requirements.txt and install only missing packages
echo "Checking and installing Python packages from requirements.txt..."
while IFS= read -r requirement || [ -n "$requirement" ]; do
    # Skip empty lines and comments
    if [ -z "$requirement" ] || [[ $requirement == \#* ]]; then
        continue
    fi

    # Extract package name from requirement line
    # This handles lines with version specifications (e.g., "package==1.0.0", "package>=1.0.0")
    package_name=$(echo "$requirement" | sed 's/[<>=!~].*//' | tr -d ' ')

    # Check if package is already installed
    if ! echo "$installed_packages" | grep -qi "^${package_name}=="; then
        echo "Installing $requirement..."
        pip install "$requirement" || error_exit "Failed to install $requirement"
    else
        echo "$package_name is already installed"
    fi
done < "requirements.txt"

echo "All installations completed successfully!"
