#!/bin/bash

# Exit on any error
set -e

# Function to check if a program is installed
is_installed() {
  command -v "$1" >/dev/null 2>&1
}

# Check for required programs
for cmd in git docker curl gh jq; do
  if ! is_installed "$cmd"; then
    echo "Error: $cmd is not installed. Please install it and try again."
    exit 1
  fi
done

# Create .env file
if [ ! -f .env ]; then
    cat << EOF > .env
# GitHub settings
GITHUB_USERNAME=wet333
REPO_NAME=fullstack_test_script

# Java and Spring settings
JAVA_VERSION=20
SPRING_VERSION=3.3.2
GROUP_ID=online.awet
ARTIFACT_ID=spring-api-test
PROJECT_NAME=spring-api-test
PROJECT_DESCRIPTION="Spring API Project"
PACKAGE_NAME=online.awet.springapi-test

# Frontend settings
NODE_VERSION=18
FRONTEND_APP_NAME=react-app

# Database settings
POSTGRES_VERSION=13
DB_NAME=myfsapp
DB_USER=username
DB_PASSWORD=password
DB_PORT=5432

# Application ports
BACKEND_PORT=8080
FRONTEND_PORT=3000
EOF
    echo ".env file created. Please fill it with your specific values and re-run the script."
    exit 0
else
    echo ".env file already exists. Using existing configuration."
fi

# Load environment variables from .env file
set -a
source .env
set +a

# Check if the repository already exists on GitHub and clone it if it does, otherwise create it
if ! gh repo create "$REPO_NAME" --public --clone 2>/dev/null; then
    echo "Repository $REPO_NAME already exists. Cloning instead..."
    gh repo clone "$GITHUB_USERNAME/$REPO_NAME" || { echo "Failed to clone repository"; exit 1; }
fi

# Change to the repository directory
cd "$REPO_NAME" || { echo "Failed to enter repository directory"; exit 1; }

echo "Repository setup complete. Continuing with the script..."

# Create project structure
mkdir -p backend frontend database

# Set up Spring Boot backend
cd backend
curl "https://start.spring.io/starter.zip" -d type=maven-project -d language=java \
     -d bootVersion="$SPRING_VERSION" -d baseDir=spring-api -d groupId="$GROUP_ID" \
     -d artifactId="$ARTIFACT_ID" -d name="$PROJECT_NAME" -d description="$PROJECT_DESCRIPTION" \
     -d packageName="$PACKAGE_NAME" -d packaging=jar -d javaVersion="$JAVA_VERSION" \
     -d dependencies=web,data-jpa,postgresql -o spring-api.zip
unzip spring-api.zip
rm spring-api.zip
cd ..

# Set up React frontend
cd frontend
npx create-react-app "$FRONTEND_APP_NAME"
cd ..

# Set up PostgreSQL
cd database
cat << EOF > init.sql
CREATE DATABASE $DB_NAME;
CREATE USER $DB_USER WITH ENCRYPTED PASSWORD '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;
EOF
cd ..

# Create Docker related files
# Backend Dockerfile
cat << EOF > backend/Dockerfile
# Build step
FROM maven AS build
WORKDIR /app
COPY ./spring-api /app
RUN mvn clean package

# Start step
FROM openjdk:$JAVA_VERSION-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
EOF

# Frontend Dockerfile with steps for Development and Production
cat << EOF > frontend/Dockerfile
FROM node:$NODE_VERSION as build
WORKDIR /app
COPY $FRONTEND_APP_NAME/package*.json ./
RUN npm install
COPY $FRONTEND_APP_NAME ./
RUN npm run build

# Development stage
FROM node:$NODE_VERSION as development
WORKDIR /app
COPY --from=build /app ./
CMD ["npm", "start"]

# Production stage
FROM nginx:alpine as production
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
EOF

# Create docker compose file for Development, docker-compose.yml
cat << EOF > docker-compose.yml
version: '3.8'
services:
  backend:
    build: ./backend
    ports:
      - "$BACKEND_PORT:$BACKEND_PORT"
    environment:
      - SPRING_DATASOURCE_URL=jdbc:postgresql://db:$DB_PORT/$DB_NAME
      - SPRING_DATASOURCE_USERNAME=$DB_USER
      - SPRING_DATASOURCE_PASSWORD=$DB_PASSWORD
    depends_on:
      - db
  frontend:
    build: ./frontend
    ports:
      - "$FRONTEND_PORT:$FRONTEND_PORT"
    volumes:
      - ./frontend/$FRONTEND_APP_NAME:/app
      - /app/node_modules
    command: npm start
  db:
    image: postgres:$POSTGRES_VERSION
    ports:
      - "$DB_PORT:$DB_PORT"
    environment:
      - POSTGRES_DB=$DB_NAME
      - POSTGRES_USER=$DB_USER
      - POSTGRES_PASSWORD=$DB_PASSWORD
    volumes:
      - ./database/init.sql:/docker-entrypoint-initdb.d/init.sql
      - pgdata:/var/lib/postgresql/data

volumes:
  pgdata:
EOF

# Create docker compose file for Production, docker-compose.prod.yml
cat << EOF > docker-compose.prod.yml
version: '3.8'
services:
  backend:
    build: ./backend
    ports:
      - "$BACKEND_PORT:$BACKEND_PORT"
    environment:
      - SPRING_DATASOURCE_URL=jdbc:postgresql://db:$DB_PORT/$DB_NAME
      - SPRING_DATASOURCE_USERNAME=$DB_USER
      - SPRING_DATASOURCE_PASSWORD=$DB_PASSWORD
    depends_on:
      - db
  frontend:
    build: ./frontend
    ports:
      - "80:80"
  db:
    image: postgres:$POSTGRES_VERSION
    ports:
      - "$DB_PORT:$DB_PORT"
    environment:
      - POSTGRES_DB=$DB_NAME
      - POSTGRES_USER=$DB_USER
      - POSTGRES_PASSWORD=$DB_PASSWORD
    volumes:
      - ./database/init.sql:/docker-entrypoint-initdb.d/init.sql
      - pgdata:/var/lib/postgresql/data

volumes:
  pgdata:
EOF

# Create .gitignore
cat << EOF > .gitignore
# Environment variables
.env

# Java
*.class
*.jar
*.war
*.ear
*.logs
*.iml
.idea/
.gradle/
build/

# Node
node_modules/
npm-debug.log
yarn-error.log

# React
/frontend/build

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db
EOF

# Spring project properties
PROPERTIES_FILE="./backend/spring-api/src/main/resources/application.properties"

# Ensure the application.properties file exists
if [ ! -f "$PROPERTIES_FILE" ]; then
    echo "application.properties file not found at $PROPERTIES_FILE"
    exit 1
fi

# Use cat to overwrite the application.properties file with new content
cat << EOF > "$PROPERTIES_FILE"
# Postgres Database
spring.datasource.url=jdbc:postgresql://localhost:${DB_PORT}/${DB_NAME}
spring.datasource.username=${DB_USER}
spring.datasource.password=${DB_PASSWORD}
spring.datasource.driver-class-name=org.postgresql.Driver

spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.hibernate.ddl-auto=update

# Application settings
server.port=${BACKEND_PORT}

# Project information
spring.application.name=${PROJECT_NAME}
spring.application.description=${PROJECT_DESCRIPTION}
EOF

echo "Spring's application.properties has been updated successfully."

echo "Project setup complete. Run docker compose up to start the application."