FROM python:3.11-slim

RUN apt-get update && apt-get install -y git build-essential curl && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone your repo
RUN git clone https://github.com/agonist-inhaler/ddg-mcp.git .

# Install hatch (build backend)
RUN pip install hatch

# Build and install your project
RUN hatch build
RUN pip install dist/ddg-mcp-0.3.0-py3-none-any.whl

EXPOSE 8080

CMD ["ddg-mcp", "--transport", "streamable-http", "--host", "0.0.0.0", "--port", "8080"]
