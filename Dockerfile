FROM maven:3.9.9-amazoncorretto-21-debian-bookworm

WORKDIR /app

COPY mvnw .
COPY .mvn/ .mvn/
COPY pom.xml .
RUN ./mvnw dependency:go-offline

COPY src/ src/
RUN ./mvnw clean package -DskipTests

EXPOSE 8080

CMD ["java", "-jar", "target/hello-docker-0.0.1-SNAPSHOT.jar"]