start_empty_java_project() {
    
    # Check if two arguments (group ID and project name) are provided
    if [ $# -ne 2 ]; then
        echo "Help --> start_empty_java_project <group_id> <project_name>"
        return 1
    fi

    group_id="$1"
    project_name="$2"

    # Create with maven
    mvn archetype:generate -DgroupId="$group_id" -DartifactId="$project_name" -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
}
