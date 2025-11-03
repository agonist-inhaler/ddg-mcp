# Use official Python slim image
FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    python3-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Clone your GitHub repo
RUN git clone https://github.com/agonist-inhaler/ddg-mcp.git .

# Install hatch for build backend (if needed later)
RUN pip install --no-cache-dir hatch

# Install your package in editable mode directly from source
RUN pip install --no-cache-dir -e .

# Expose the port the app runs on
EXPOSE 8080

# Default command to run the MCP server
CMD ["ddg-mcp", "--transport", "streamable-http", "--host", "0.0.0.0", "--port", "8080"]
