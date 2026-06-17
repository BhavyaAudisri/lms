# ---------- Stage 1: Build the application ----------
FROM maven:3.8.7-eclipse-temurin-17 AS builder

# Set working directory
WORKDIR /app

# Copy Maven config first (to cache dependencies)
COPY pom.xml .

# Download dependencies (cached for faster rebuilds)
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build application without running tests
RUN mvn clean package -DskipTests


# ---------- Stage 2: Create lightweight runtime image ----------
FROM eclipse-temurin:17-jre-alpine

# Create non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set working directory
WORKDIR /app

# Copy built jar from build stage
COPY --from=builder /app/target/*.jar app.jar

# Set ownership & switch to non-root user
RUN chown -R appuser:appgroup /app
USER appuser

# Expose application port (configurable)
ENV APP_PORT=8080
EXPOSE ${APP_PORT}

# Set JVM options (can be overridden at runtime)
ENV JAVA_OPTS="-Xms256m -Xmx512m"

# Add a healthcheck (good DevOps practice)
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://localhost:${APP_PORT}/actuator/health || exit 1

# Logging - redirect stdout/stderr to Docker logs
# (This is automatic if you use `java -jar`, but we can enforce it)
ENV LOGGING_PATH=/app/logs
VOLUME ["/app/logs"]

# Entrypoint with environment variable support
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar --server.port=${APP_PORT}"]