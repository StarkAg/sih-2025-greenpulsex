# 🚀 Deploying GreenPulseX to Vercel

## Overview

**Frontend (Next.js)** → ✅ **Can be hosted on Vercel**  
**Backend (FastAPI)** → ❌ **Cannot be hosted on Vercel** (use Render, Railway, or Fly.io)

## Step 1: Deploy Frontend to Vercel

### Option A: Using Vercel CLI (Recommended)

1. **Install Vercel CLI:**
   ```bash
   npm i -g vercel
   ```

2. **Login to Vercel:**
   ```bash
   vercel login
   ```

3. **Navigate to frontend directory:**
   ```bash
   cd hackathons/GreenPulseX/frontend
   ```

4. **Deploy:**
   ```bash
   vercel
   ```
   Follow the prompts. For production:
   ```bash
   vercel --prod
   ```

### Option B: Using Vercel Dashboard

1. Go to [vercel.com](https://vercel.com) and sign up/login
2. Click "Add New Project"
3. Import your Git repository (or upload the `frontend` folder)
4. Configure:
   - **Framework Preset:** Next.js
   - **Root Directory:** `frontend` (if deploying from root)
   - **Build Command:** `npm run build`
   - **Output Directory:** `.next`

## Step 2: Set Environment Variables in Vercel

In your Vercel project settings, add these environment variables:

```
NEXT_PUBLIC_API_URL=https://your-backend-url.com
NEXT_PUBLIC_WS_URL=wss://your-backend-url.com
```

**Important:** Replace `your-backend-url.com` with your actual backend URL (see Step 3).

## Step 3: Deploy Backend (Required!)

Since Vercel can't host Python/FastAPI, you need to deploy the backend separately:

### Option A: Render (Easiest - Free Tier Available)

1. Go to [render.com](https://render.com)
2. Create a new **Web Service**
3. Connect your GitHub repo
4. Settings:
   - **Build Command:** `pip install -r requirements.txt`
   - **Start Command:** `uvicorn app.main:app --host 0.0.0.0 --port $PORT`
   - **Root Directory:** `backend`
5. Add environment variables from `backend/env.example`

### Option B: Railway (Easy - Free Trial)

1. Go to [railway.app](https://railway.app)
2. Create new project → Deploy from GitHub
3. Select your repo
4. Add service → Select `backend` directory
5. Railway auto-detects Python and deploys
6. Add environment variables

### Option C: Fly.io (Good for Full-Stack)

1. Install Fly CLI: `curl -L https://fly.io/install.sh | sh`
2. Login: `fly auth login`
3. In `backend` directory: `fly launch`
4. Follow prompts

### Option D: Use Vercel Serverless Functions (Advanced)

Convert FastAPI endpoints to Vercel serverless functions. This requires refactoring.

## Step 4: Update Frontend Environment Variables

After backend is deployed, update Vercel environment variables:

1. Go to your Vercel project → Settings → Environment Variables
2. Update `NEXT_PUBLIC_API_URL` to your backend URL
3. Redeploy frontend

## Quick Deploy Commands

```bash
# 1. Deploy frontend to Vercel
cd hackathons/GreenPulseX/frontend
vercel --prod

# 2. Your frontend will be live at: https://your-project.vercel.app
# 3. Deploy backend to Render/Railway (see Step 3)
# 4. Update NEXT_PUBLIC_API_URL in Vercel settings
# 5. Redeploy frontend
```

## Environment Variables Checklist

### Frontend (Vercel):
- ✅ `NEXT_PUBLIC_API_URL` - Your backend URL
- ✅ `NEXT_PUBLIC_WS_URL` - WebSocket URL (if using)

### Backend (Render/Railway):
- ✅ `DATABASE_URL` - PostgreSQL connection string
- ✅ `REDIS_URL` - Redis connection string (optional)
- ✅ `SECRET_KEY` - Random secret key
- ✅ `CORS_ORIGINS` - Your Vercel frontend URL

## Troubleshooting

### CORS Errors
- Make sure `CORS_ORIGINS` in backend includes your Vercel URL
- Format: `["https://your-app.vercel.app"]`

### API Connection Issues
- Check `NEXT_PUBLIC_API_URL` is correct
- Ensure backend is running and accessible
- Check browser console for errors

### Build Errors
- Make sure all dependencies are in `package.json`
- Check `next.config.js` is correct
- Review build logs in Vercel dashboard

## Cost Estimate

- **Vercel Frontend:** Free (Hobby plan) or $20/month (Pro)
- **Render Backend:** Free tier available (spins down after 15 min inactivity)
- **Railway:** $5/month after free trial
- **Database:** 
  - Render PostgreSQL: $7/month
  - Supabase: Free tier available
  - Railway PostgreSQL: Included

## Recommended Setup

1. **Frontend:** Vercel (Free)
2. **Backend:** Render (Free tier) or Railway ($5/month)
3. **Database:** Supabase (Free tier) or Render PostgreSQL ($7/month)

Total: **$0-12/month** for a fully hosted application!

---

**Need help?** Check the main [README.md](./README.md) or [DEPLOYMENT.md](./docs/DEPLOYMENT.md)

