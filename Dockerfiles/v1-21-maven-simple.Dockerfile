FROM maven:3.9.9-amazoncorretto-21-debian-bookworm

# Maven Wrapper + Dependencies
COPY mvnw .
COPY .mvn/ .mvn/
COPY pom.xml .
RUN ./mvnw dependency:go-offline

# Source Code
COPY src/ src/

# Build jar
RUN ./mvnw clean package -DskipTests

ARG JAR_FILE=target/*.jar

COPY ${JAR_FILE} app.jar

EXPOSE 8080

CMD ["java", "-jar", "/app.jar"]