FROM python:3.11-slim

# Install system dependencies needed for building and git
RUN apt-get update && \
    apt-get install -y git build-essential curl python3-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone your repo
RUN git clone https://github.com/agonist-inhaler/ddg-mcp.git .

# Install hatch separately
RUN pip install --no-cache-dir hatch

# Try building the wheel package (you can comment this line to skip wheel build)
RUN hatch build

# Install the built wheel
RUN pip install --no-cache-dir dist/ddg-mcp-0.3.0-py3-none-any.whl

# Fallback: If you want to skip wheel building, comment out above 2 RUN lines and uncomment below
# RUN pip install --no-cache-dir -e .

EXPOSE 8080

CMD ["ddg-mcp", "--transport", "streamable-http", "--host", "0.0.0.0", "--port", "8080"]

