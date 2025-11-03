# Use official Python slim image
FROM python:3.11-slim

# Install dependencies needed for build and runtime
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    curl \
  && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Clone the repo into /app
RUN git clone https://github.com/agonist-inhaler/ddg-mcp.git .

# Install hatch (build backend) and build & install the package in one RUN for caching
RUN pip install --no-cache-dir hatch && \
    hatch build && \
    pip install --no-cache-dir dist/ddg-mcp-0.3.0-py3-none-any.whl

# Expose the port the app runs on
EXPOSE 8080

# Run the MCP server with streamable-http transport
CMD ["ddg-mcp", "--transport", "streamable-http", "--host", "0.0.0.0", "--port", "8080"]

