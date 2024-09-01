#!/bin/bash

curl -s "https://get.sdkman.io" | bash

source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk version

sdk install java

# sdk install java 22.0.2-tem
# sdk install java 21.0.4-tem
# sdk install java 17.0.12-tem
# sdk install java 11.0.24-tem
# sdk install java 8.0.422-tem
# sdk default java 21.0.4-tem

sdk install maven
sdk install gradle
sdk install micronaut
sdk install springboot