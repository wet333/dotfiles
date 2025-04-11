#!/bin/bash

echo "Setting up Java development software and tools..."

# Checks if specific sdk is already installed, install it if not
install_or_skip() {
    sdk_name=$1

    if sdk list "$sdk_name" | grep -q "installed"; then
        echo "$sdk_name is already installed, skipping..."
    else
        echo "Installing $sdk_name"
        sdk install "$sdk_name"
    fi
}

# Check if sdkman is previously installed
if [ -d "$HOME/.sdkman" ]; then
    echo "SDKMAN is already installed. Skipping SDKMAN installation."
    source "$HOME/.sdkman/bin/sdkman-init.sh"
else
    echo "Installing SDKMAN..."
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

sdk version

install_or_skip java

# Optional specific java versions
# install_or_skip java 22.0.2-tem
# install_or_skip java 21.0.4-tem
# install_or_skip java 17.0.12-tem
# install_or_skip java 11.0.24-tem
# install_or_skip java 8.0.422-tem
# install_or_skip java 21.0.4-tem

install_or_skip maven
install_or_skip gradle
install_or_skip micronaut
install_or_skip springboot

echo "Java is ready to code!"