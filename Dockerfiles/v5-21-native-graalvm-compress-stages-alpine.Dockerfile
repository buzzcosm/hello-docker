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
RUN ./mvnw native:compile -Pnative -DskipTests

# --- STAGE 2: UPX compression ---
FROM frolvlad/alpine-glibc AS compress-stage

RUN apk add --no-cache upx

WORKDIR /compress

# Copy binary from native-build
COPY --from=native-build /build/target/hello-docker .

# Compress binary
RUN upx --best --lzma hello-docker

# --- STAGE 3: Final minimal image ---
FROM frolvlad/alpine-glibc
# /usr/local/bin
# If you only have one binary (such as hello-docker) that should be available system-wide.
# Advantage: Is in the PATH, can be executed without specifying a path.
COPY --from=compress-stage /compress/hello-docker /usr/local/bin/app
CMD ["app"]