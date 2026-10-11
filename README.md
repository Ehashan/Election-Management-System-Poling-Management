# Election Polling Station System

A secure, machine-learning-powered web application built with Django for polling stations during an election. This system allows poll workers to securely verify voters' identities using their National Identity Card (NIC) and real-time facial recognition.

## 🌟 Key Features
- **Poll Worker Authentication**: Secure login system restricting access to authorized poll workers only.
- **NIC Lookup**: Quickly search for a registered voter's details using their National Identity Card (NIC) number.
- **Real-time Face Verification**: Compares the voter's live camera feed against their registered database photo to prevent identity fraud.
- **Liveness Detection**: Integrated checks (e.g. blink detection) to ensure the camera feed is from a live person and not a spoofed photo.
- **Database Logging**: Keeps track of verification attempts (both successful and failed) in MongoDB.

## 💻 Tech Stack
- **Backend Framework**: Django 5.x
- **Database**: MongoDB (via `pymongo`)
- **Machine Learning & Vision**: 
  - `insightface` & `deepface` (Facial embedding & matching)
  - `mediapipe` (Face mesh / Liveness)
  - `opencv-python` (Camera and image frame processing)
- **Frontend**: HTML, Vanilla CSS, JavaScript

## 🚀 Setup & Installation

### 1. Prerequisites
- Python 3.10+
- A MongoDB cluster (e.g. MongoDB Atlas)
- C/C++ build tools & CUDA (Recommended for faster ML processing)

### 2. Environment Setup
Create a virtual environment and activate it:
```bash
python -m venv venv
# On Windows
venv\Scripts\activate
# On Mac/Linux
source venv/bin/activate
```

### 3. Install Dependencies
Install the required packages from the `requirements.txt` file:
```bash
pip install -r requirements.txt
```

### 4. Configure Environment Variables
Create a `.env` file in the root directory (same level as `manage.py`) and add your sensitive credentials:
```env
SECRET_KEY="your-django-secret-key"
DEBUG=True
MONGO_URI="mongodb+srv://<username>:<password>@cluster.mongodb.net/?appName=Cluster0"
MONGO_DB_NAME="Election_Management_System"
```
*(Note: Never commit your `.env` file to version control. It is already included in `.gitignore`.)*

### 5. Run the Application
Start the Django development server:
```bash
python manage.py runserver
```

Open your browser and navigate to `http://127.0.0.1:8000/`. You will be prompted to log in as a poll worker to access the verification dashboard.

## 🔐 Security Notes
- Ensure your `.env` file is never uploaded to GitHub. 
- In a production environment, always set `DEBUG=False`.
- Use an ASGI/WSGI server (like Gunicorn or Daphne) for production deployments instead of the development server.
