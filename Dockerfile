# Stage 1: Build and test
FROM node:20 AS build

WORKDIR /app

# Install curl for testing
RUN apt-get update && apt-get install -y curl

# Copy application files
COPY calculator.html .
COPY server.js .
COPY testscript.sh .

# Make the test script executable
RUN chmod +x testscript.sh

# Run the test script
RUN ./testscript.sh

# Stage 2: Final image
FROM node:20

WORKDIR /app

# Copy only necessary files from build stage
COPY --from=build /app/calculator.html .
COPY --from=build /app/server.js .

# Expose port
EXPOSE 5000

# Start the application
CMD ["node", "server.js"]
