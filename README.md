# Reservation Prediction

A Machine Learning project for automating reservation outcome predictions, featuring a robust MLOps pipeline. The repository includes data ingestion from Google Cloud Storage, preprocessing, model training, and deployment on Google Cloud Run, all orchestrated via Jenkins and Docker.

## Features

- **Automated Data Ingestion**: Downloads and splits raw data from GCP buckets for model development.
- **Data Preprocessing**: Cleans, transforms, balances, and selects features for training and testing datasets.
- **Model Training**: Trains a LightGBM model using scikit-learn and logs experiments with MLflow.
- **Deployment Pipeline**: Builds and pushes Docker images to Google Container Registry and deploys the model to Google Cloud Run.
- **CI/CD Integration**: Jenkins pipeline automates the complete workflow, including environment setup, model training, Dockerization, and cloud deployment.
- **Flask API**: Exposes a prediction endpoint for integration into other services or frontends.

## Project Structure

```
.
├── application.py               # Flask app serving the trained model
├── pipeline/
│   └── training_pipeline.py     # Orchestrates the full ML workflow
├── src/
│   ├── data_ingestion.py        # Ingests and splits data from GCP
│   ├── data_preprocessing.py    # Preprocesses and balances data
│   ├── model_training.py        # Trains and evaluates the model
│   ├── custom_exception.py      # Custom error handling
│   ├── logger.py                # Logging utilities
├── config/
│   ├── model_params.py          # Model hyperparameters
│   ├── paths_config.py          # Centralized path configs
├── utils/
│   └── common_functions.py      # YAML and data loading helpers
├── Dockerfile                   # Application containerization
├── Jenkinsfile                  # CI/CD pipeline definition
├── requirements.txt             # Python dependencies
├── setup.py                     # Package definition
└── custom_jenkins/Dockerfile    # Jenkins (DinD) setup for CI/CD
```

## Getting Started

### Prerequisites

- Python 3.x
- Google Cloud SDK & credentials
- Docker
- Jenkins (optional, for CI/CD)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/dananjayaabeytd/Reservation-Prediction.git
   cd Reservation-Prediction
   ```

2. **Install dependencies:**
   ```bash
   python -m venv venv
   source venv/bin/activate
   pip install --upgrade pip
   pip install -e .
   ```

3. **Configure GCP credentials:**
   - Place your GCP service account key in a secure location and update pipeline/environment configs accordingly.

### Usage

- **Local Training Pipeline:**
  ```bash
  python pipeline/training_pipeline.py
  ```

- **Run the Flask API:**
  ```bash
  python application.py
  ```
  The API will be available at `http://localhost:5000/`.

- **Dockerized Workflow:**
  ```bash
  docker build -t reservation-prediction .
  docker run -p 5000:5000 reservation-prediction
  ```

- **CI/CD with Jenkins:**
  - The `Jenkinsfile` automates fetching the repo, setting up the environment, building/pushing Docker images, and deploying to Cloud Run.

## Technologies Used

- Python, Jupyter Notebook
- scikit-learn, LightGBM, imbalanced-learn
- pandas, numpy, PyYAML, Flask, MLflow
- Google Cloud Storage, Google Cloud Run, Google Container Registry
- Docker, Jenkins
