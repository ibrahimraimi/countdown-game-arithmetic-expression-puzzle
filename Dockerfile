# Use a lightweight Alpine Linux image
FROM alpine:3.22

# Install bash and bc (for arithmetic operations)
RUN apk add --no-cache bash bc

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Make the solver script executable
RUN chmod +x /app/src/solution.sh

# Run the solution when the container launches
CMD ["/app/src/solution.sh"]