#!/bin/bash
set -e

echo "🔁 Recreating .venv"
rm -rf .venv
python3 -m venv .venv
source .venv/bin/activate

echo "⬆️ Installing runtime requirements"
pip install --upgrade pip
pip install -r requirements.txt
pip install build

echo "🧼 Cleaning old builds"
rm -rf build dist *.egg-info
find . -type d -name __pycache__ -exec rm -rf {} +

echo "📦 Building pyconnector package"
python -m build

echo "📥 Installing pyconnector"
pip install dist/pyconnector-*.whl

echo "🧪 Testing import"
python -c "from pyconnector.postgres.connector import PostgresConnector; print('✅ PostgresConnector imported')"
python -c "from pyconnector.databricks.connector import DatabricksConnector; print('✅ DatabricksConnector imported')"
