import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    SECRET_KEY = os.getenv('SECRET_KEY', 'dev-key-for-development-only')
    SQLALCHEMY_DATABASE_URI = os.getenv('DATABASE_URL', 'sqlite:///traffic_analyzer.db')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    UPLOAD_FOLDER = os.path.join(os.path.abspath(os.path.dirname(__file__)), 'app', 'static', 'uploads')
    ALLOWED_EXTENSIONS = {'pcap', 'csv', 'log', 'txt'}
    MAX_CONTENT_LENGTH = 16 * 1024 * 1024  # 16MB max upload size
