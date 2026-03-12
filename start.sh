#!/bin/bash

# 1. Start Main Execution Server in the background
cd /app/server
uvicorn main:app --host 0.0.0.0 --port 8001 &

# 2. Start RAG Server in the background
cd /app/rag_service
uvicorn app:app --host 0.0.0.0 --port 8002 &

# 3. Start Next.js Client in the foreground
# Render automatically assigns the $PORT environment variable to expose to the web
cd /app/ezzzit-client
npm start -- -p $PORT
