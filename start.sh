#!/bin/bash
# Kill any process on port 3333
lsof -ti:3333 | xargs kill -9 2>/dev/null

echo "Starting Christmas Light Visualizer on port 3333..."
# Start serve
npx -y serve -l 3333 .
