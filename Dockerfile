# Use an official Java runtime as a parent image
FROM maven:3.8.4-jdk-11-slim AS build

COPY . .

RUN mvn clean package -DskipTests

FROM openjdk:11-jdk-slim

# Set the working directory
WORKDIR /app

# Add the application's JAR file to the container
COPY --from=build target/demo-0.0.1-SNAPSHOT.jar app.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]