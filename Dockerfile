# Use a base image with Java and Maven pre-installed
FROM maven:3.8.4-openjdk-11 AS builder

# Set the working directory inside the container
WORKDIR /app


COPY . /app


# Build the application
RUN mvn package

# Create the final image with only the necessary files
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=builder /app/target/devops-integration.jar ./devops-integration.jar

# Specify the command to run the application
ENTRYPOINT ["java","-jar","./devops-integration.jar"]
