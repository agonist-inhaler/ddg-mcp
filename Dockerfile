# Use official lightweight Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app

# Install system dependencies for building packages (if needed)
RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Expose port the MCP server will run on
EXPOSE 8080

# Default command to run your MCP server
CMD ["ddg-mcp", "--transport", "streamable-http", "--host", "0.0.0.0", "--port", "8080"]
