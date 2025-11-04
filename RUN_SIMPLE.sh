#!/bin/bash
echo "🚀 Starting GreenPulseX..."

# Terminal 1: Backend
echo "📦 Starting Backend..."
cd backend
source venv/bin/activate
echo "✅ Backend running on http://localhost:8000"
uvicorn app.main:app --reload &
BACKEND_PID=$!

sleep 2

# Terminal 2: Frontend  
echo "📦 Starting Frontend..."
cd ../frontend
npm run dev &
FRONTEND_PID=$!

echo ""
echo "✅ GreenPulseX is running!"
echo "📍 Frontend: http://localhost:3000"
echo "📍 Backend:  http://localhost:8000"
echo "📍 API Docs: http://localhost:8000/docs"
echo ""
echo "Press Ctrl+C to stop"

wait
