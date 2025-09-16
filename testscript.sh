#!/bin/sh

echo "Starting test script..."

# Check if calculator.html exists
if [ ! -f calculator.html ]; then
  echo "calculator.html not found: Test failed"
  exit 1
fi

# Start the server in the background
node server.js &
SERVER_PID=$!

# Wait for the server to start
sleep 3

# Perform HTTP request to check if server is responding
HTTP_RESPONSE=$(curl --write-out "%{http_code}" --silent --output /dev/null http://localhost:5000)

if [ "$HTTP_RESPONSE" -eq 200 ]; then
  echo "Server is responding: Test passed"
else
  echo "Server not responding or error occurred: Test failed"
  kill $SERVER_PID
  exit 1
fi

# Stop the server
kill $SERVER_PID

echo "All tests passed!"
exit 0
