# --- STAGE 1: Build image ---
FROM maven:3.9.9-amazoncorretto-21-debian-bookworm AS build

WORKDIR /app

# Maven Wrapper + Dependencies
COPY mvnw .
COPY .mvn/ .mvn/
COPY pom.xml .
RUN ./mvnw dependency:go-offline

# Source Code
COPY src/ src/

# Build jar
RUN ./mvnw clean package -DskipTests

# --- STAGE 2: Final minimal image ---
FROM eclipse-temurin:21-jre

ARG JAR_FILE=/app/target/*.jar

COPY --from=build ${JAR_FILE} app.jar

EXPOSE 8080

CMD ["java", "-jar", "/app.jar"]