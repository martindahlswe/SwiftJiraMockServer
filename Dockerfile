# Use an official Swift image
FROM swift:5.7 as builder

# Set the working directory
WORKDIR /app

# Copy the project files into the container
COPY . .

# Build the Swift executable
RUN swift build --configuration release

# Use a minimal runtime image
FROM swift:5.7-slim

# Set the working directory
WORKDIR /app

# Copy the built executable from the builder image
COPY --from=builder /app/.build/release/Run /app/Run

# Expose the port the server runs on
EXPOSE 8080

# Run the server
CMD ["./Run"]
