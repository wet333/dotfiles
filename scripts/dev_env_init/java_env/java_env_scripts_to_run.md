# Commands to run

for some reason the terminal couldnt run this automatically

### Install Java 20
sdk install java 20.0.1-tem

### Install Java 17
sdk install java 17.0.9-tem

### Install Java 11
sdk install java 11.0.21-tem

### Install Java 8
sdk install java 8.0.402-tem

### Install Maven
sdk install maven

### Install Gradle
sdk install gradle

### Set Java 20 as default
sdk default java 20.0.1-tem


## Display installed versions

echo "Installed versions:"
sdk list java | grep installed
sdk list maven | grep installed
sdk list gradle | grep installed
