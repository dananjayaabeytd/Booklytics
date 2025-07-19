# Use a lightweight official Python base image (Debian-based)
# 'slim' minimizes image size while maintaining compatibility with most packages
FROM python:slim

# Set environment variables:
# - Prevents Python from creating .pyc files
# - Ensures stdout and stderr are streamed immediately (useful for logging)
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set the working directory inside the container to /app
# All subsequent commands will run in this directory
WORKDIR /app

# Install system-level dependencies required by LightGBM
# - libgomp1: OpenMP runtime library (required for LightGBM's parallel computation)
# - Clean up cached files to reduce final image size
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy all files from the host's current directory into the container's working directory (/app)
COPY . .

# Install the current Python package in editable mode
# -e . means install the package defined by the setup.py in editable/development mode
RUN pip install --no-cache-dir -e .

# Run the training pipeline before the application starts
# This typically trains and saves the model to be used by the Flask app
RUN python pipeline/training_pipeline.py

# Expose port 5000 to allow access to the Flask server from outside the container
EXPOSE 5000

# Define the default command to start the Flask application
CMD ["python", "application.py"]
