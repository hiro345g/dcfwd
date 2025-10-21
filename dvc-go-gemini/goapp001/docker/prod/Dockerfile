# ---- Build Stage ----
FROM golang:1.24.5-slim-bullseye AS builder

# Set the working directory
WORKDIR /app

# Copy go module and sum files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy the source code
COPY . .

# Build the application as a static binary
RUN CGO_ENABLED=0 go build -o /goapp .

# ---- Final Stage ----
FROM gcr.io/distroless/static-debian11

# Set the working directory
WORKDIR /app

# Set the default environment to production
ENV APP_ENV prod

# Copy the compiled binary from the builder stage
COPY --from=builder /goapp .

# Copy the configuration file
COPY conf/ ./conf/

# Set the command to run the application
CMD ["/app/goapp"]
