# Use the specified Go version
FROM golang:1.24.5-bullseye

# Set the working directory inside the container
WORKDIR /app

# Copy go module and sum files
COPY go.mod go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source code into the container
COPY . .

# Command to run the tests
CMD ["go", "test", "./..."]
