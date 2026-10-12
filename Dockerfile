# Official Python base image
FROM python:3.11-slim

# Prevent Python from writing .pyc files and enable unbuffered logging
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies required for OpenCV, InsightFace, MediaPipe, Pillow, etc.
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    libgl1 \
    libglib2.0-0 \
    libgomp1 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set working directory inside container
WORKDIR /app

# Upgrade pip
RUN pip install --no-cache-dir --upgrade pip

# Install core scientific and computer vision packages
RUN pip install --no-cache-dir numpy pillow opencv-python scikit-learn

# Install ONNX, MediaPipe and InsightFace
RUN pip install --no-cache-dir onnx onnxruntime mediapipe insightface

# Install Deep Learning packages (TensorFlow, tf-keras, DeepFace)
RUN pip install --no-cache-dir tensorflow tf-keras deepface

# Install application dependencies (Django, MongoDB, dotenv, qrcode, etc.)
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . /app/

# Normalize entrypoint script line endings (handles Windows CRLF) and make it executable
RUN sed -i 's/\r$//' /app/entrypoint.sh && chmod +x /app/entrypoint.sh

# Expose Django port 8000
EXPOSE 8000

# Set entrypoint to run migrations before server startup
ENTRYPOINT ["/app/entrypoint.sh"]

# Start Django development server bound to 0.0.0.0 on port 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
