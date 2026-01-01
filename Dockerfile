# Use official Python image
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Copy your files into the container
COPY index.html test.py ./

# Expose port 8000 (for HTTP server)
EXPOSE 8000

# Run a command to start both the HTTP server and your Python script
# Using 'sh -c' to run multiple commands
CMD sh -c "python test.py & python -m http.server 8000"