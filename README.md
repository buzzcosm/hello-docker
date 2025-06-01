# Hello Docker

A simple Spring Boot application demonstrating various Docker containerization approaches for Java applications.

## Description

This project showcases how to containerize a Spring Boot application using different Docker strategies:
- Standard JAR-based containerization
- Multi-stage builds for optimized images
- GraalVM native image compilation for smaller footprint and faster startup

The application itself is a minimal REST API with a single endpoint:
- `GET /` - Returns the greeting message "Hello Docker 👋"

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

| # | Dockerfile | Image Size |
|---|------------|------------|
| 1 | Dockerfile_jar_simple | ~637 MB |
| 2 | Dockerfile_jar_stages | ~332 MB |
| 3 | Dockerfile_native | ~177 MB |
| 4 | Dockerfile_native_oracle | ~177 MB |
| 5 | Dockerfile_native_oracle_tiny | ~100 MB |
| 6 | Dockerfile_native_upx | ~37 MB |

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

Image size: ~332 MB

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

Image size: ~177 MB

### 5. Oracle GraalVM Native Image (Tiny)

The most optimized version using Oracle's GraalVM and a minimal base image.

```bash
# Build the image
docker build -f Dockerfiles/Dockerfile_native_oracle_tiny -t hello-docker:latest .

# Run with Docker Compose
docker compose up -d
```

Image size: ~100 MB

### 6. UPX-compressed Native Image

The smallest possible image using Oracle's GraalVM with UPX compression for extreme size reduction.

```bash
# Build the image
docker build -f Dockerfiles/Dockerfile_native_upx -t hello-docker:latest .

# Run with Docker Compose
docker compose up -d
```

Image size: ~37 MB

## Dockerfile commands

* FROM initializes the build stage and defines the base image to build on.
* WORKDIR sets the working directory for any RUN, CMD, ENTRYPOINT, COPY, and ADD directives that follow in the Dockerfile.
* COPY copies new files or directories into the Docker image.
* RUN executes commands on top of the current image as a new layer and commits the results.
* EXPOSE configures Docker to open a specific network port for listening on the container, in this case port 8080.
* ENV sets environment variables.
* CMD provides the default execution command when the container is run.
