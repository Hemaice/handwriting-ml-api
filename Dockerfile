# Use a stable Python version that supports SciPy wheels
FROM python:3.10-slim

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install required system dependencies for SciPy, NumPy, and OpenCV
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    gfortran \
    libatlas-base-dev \
    liblapack-dev \
    libjpeg-dev \
    libpng-dev \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy repo files
COPY . /app

# Upgrade pip
RUN pip install --upgrade pip

# Install dependencies
RUN pip install -r requirements.txt

# Expose port (Render will map automatically)
EXPOSE 10000

# Start the Flask app using gunicorn
CMD ["gunicorn", "app:app", "--preload", "--bind", "0.0.0.0:10000"]
