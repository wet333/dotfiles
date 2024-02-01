# Uninstall SDKMAN
rm -rf ~/.sdkman

# Run the install script from SDKMAN
curl -s "https://get.sdkman.io" | bash

source "$HOME/.sdkman/bin/sdkman-init.sh"
