# Use Python as the base image
FROM python:3.11-slim

# Install Node.js (for Next.js) and curl
RUN apt-get update && apt-get install -y curl
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs

# Set working directory
WORKDIR /app

# Copy the entire monorepo
COPY . .

# --- Build the Frontend ---
WORKDIR /app/ezzzit-client
RUN npm install
RUN npm run build

# --- Setup Main Server ---
WORKDIR /app/server
RUN pip install -r requirements.txt

# --- Setup RAG Service ---
WORKDIR /app/rag_service
RUN pip install -r requirements.txt

# Return to root
WORKDIR /app

# Make the start script executable
RUN chmod +x start.sh

# The Single Start Command
CMD ["./start.sh"]
