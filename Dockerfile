FROM node:20

WORKDIR /app

# Copy application files
COPY calculator.html .
COPY server.js .

# Copy the test script into the image
COPY testscript.sh .

# Make the test script executable
RUN chmod +x testscript.sh

# Expose port
EXPOSE 5000

# Default command to run the app
CMD ["node", "server.js"]
