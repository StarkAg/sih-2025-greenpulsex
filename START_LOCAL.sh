#!/bin/bash

# GreenPulseX Local Development Startup Script

echo "🚀 Starting GreenPulseX Locally..."
echo ""

# Check if we're in the right directory
if [ ! -d "backend" ] || [ ! -d "frontend" ]; then
    echo "❌ Error: Please run this script from the GreenPulseX root directory"
    exit 1
fi

# Start Backend
echo "📦 Starting Backend Server..."
cd backend
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

source venv/bin/activate
pip install -q 'uvicorn[standard]' 'python-jose[cryptography]' 'passlib[bcrypt]' fastapi python-multipart python-decouple 'pydantic==1.10.12' email-validator httpx sqlalchemy alembic redis aioredis paho-mqtt scikit-learn pandas numpy joblib prometheus-client structlog 2>/dev/null

if [ ! -f .env ]; then
    cp env.example .env
    echo "✅ Created .env file from env.example"
fi

echo "✅ Backend dependencies ready"
echo "🌐 Starting backend on http://localhost:8000"
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000 &
BACKEND_PID=$!
cd ..

# Wait a bit for backend to start
sleep 3

# Start Frontend
echo ""
echo "📦 Starting Frontend Server..."
cd frontend
if [ ! -d "node_modules" ]; then
    echo "Installing frontend dependencies..."
    npm install
fi

echo "✅ Frontend dependencies ready"
echo "🌐 Starting frontend on http://localhost:3000"
npm run dev &
FRONTEND_PID=$!
cd ..

echo ""
echo "✅ GreenPulseX is running!"
echo ""
echo "📍 Access URLs:"
echo "   Frontend:  http://localhost:3000"
echo "   Backend:   http://localhost:8000"
echo "   API Docs:  http://localhost:8000/docs"
echo ""
echo "⚠️  Note: You may need PostgreSQL and Redis running for full functionality"
echo ""
echo "Press Ctrl+C to stop all services"

# Wait for user interrupt
trap "kill $BACKEND_PID $FRONTEND_PID 2>/dev/null; exit" INT TERM
wait

