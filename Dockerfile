# Use a lightweight base image
FROM alpine:latest

# Set a working directory
WORKDIR /app

# Copy the entrypoint script into the image
COPY entrypoint.sh .

# Make the script executable
RUN chmod +x entrypoint.sh

# Define the entrypoint
ENTRYPOINT ["./entrypoint.sh"]
