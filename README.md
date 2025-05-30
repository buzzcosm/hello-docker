# Hello Docker

A simple Spring Boot application demonstrating various Docker containerization approaches for Java applications.

## Description

This project showcases how to containerize a Spring Boot application using different Docker strategies:
- Standard JAR-based containerization
- Multi-stage builds for optimized images
- GraalVM native image compilation for smaller footprint and faster startup

The application itself is a minimal REST API that returns a greeting message.

## Prerequisites

- Java 21
- Docker
- Docker Compose
- Maven 3.9+ (or use the included Maven wrapper)

## Getting Started

### Clone the Repository

```bash
git clone https://github.com/buzzcosm/hello-docker.git
cd hello-docker
```

### Build and Run Locally

```bash
./mvnw clean package
java -jar target/hello-docker.jar
```

The application will be available at http://localhost:8080

## Docker Containerization Options

### 1. Simple JAR-based Image

This approach packages the application as a JAR file and runs it on a JVM.

```bash
# Build the image
docker build -f Dockerfiles/Dockerfile_jar_simple -t hello-docker:latest .

# Run with Docker Compose
docker compose up -d

# Test the application
curl http://localhost:8080

# Stop the container
docker compose down -v
```

Image size: ~637 MB

### 2. Multi-stage JAR-based Image

A more optimized approach using multi-stage builds.

```bash
# Build the image
docker build -f Dockerfiles/Dockerfile_jar_stages -t hello-docker:latest .

# Run with Docker Compose
docker compose up -d
```

### 3. GraalVM Native Image

Compiles the application to a native executable for faster startup and lower memory usage.

```bash
# Build the image
docker build -f Dockerfiles/Dockerfile_native -t hello-docker:latest .

# Run with Docker Compose
docker compose up -d
```

Image size: ~177 MB

### 4. Oracle GraalVM Native Image

Uses Oracle's GraalVM distribution for native image compilation.

```bash
# Build the image
docker build -f Dockerfiles/Dockerfile_native_oracle -t hello-docker:latest .

# Run with Docker Compose
docker compose up -d
```

### 5. Oracle GraalVM Native Image (Tiny)

The most optimized version using Oracle's GraalVM and a minimal base image.

```bash
# Build the image
docker build -f Dockerfiles/Dockerfile_native_oracle_tiny -t hello-docker:latest .

# Run with Docker Compose
docker compose up -d
```

## Project Structure

- `src/main/java` - Java source code
- `src/main/resources` - Application configuration
- `Dockerfiles/` - Various Dockerfile implementations
- `docker-compose.yml` - Docker Compose configuration

## Technologies Used

- Spring Boot 3.5.0
- Java 21
- GraalVM
- Docker
- Maven

## Development

### Running Tests

```bash
./mvnw test
```

### Building Native Image Locally

```bash
./mvnw native:compile -Pnative
```

## License

[MIT License](LICENSE)
