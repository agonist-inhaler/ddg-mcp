version: "3.9"
services:
  ddg-mcp:
    build:
      context: https://github.com/agonist-inhaler/ddg-mcp.git
      dockerfile: Dockerfile
    container_name: ddg-mcp
    ports:
      - "8080:8080"
    restart: unless-stopped
