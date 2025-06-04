# --- STAGE 1: Build native image ---
#FROM container-registry.oracle.com/graalvm/native-image:21 AS native-build
FROM mvkvl/graalvm:native-image-community-21-maven-3.9.6 AS native-build

WORKDIR /build

# Maven Wrapper + Dependencies
COPY mvnw .
COPY .mvn/ .mvn/
COPY pom.xml .
RUN ./mvnw dependency:go-offline

# Source Code
COPY src/ src/

# Build native binary
RUN ./mvnw native:compile -B -Pnative -DskipTests

# --- STAGE 2: Final minimal image ---
FROM debian:bookworm-slim

WORKDIR /app

COPY --from=native-build /build/target/hello-docker /app/application

CMD ["/app/application"]
