# Initilised the development environment repository.
# This script should be idempotent.
set -e

chmod +x -R ./scripts/*

if [ -f ./.env ]; then
    source ./.env
else
    echo "# Use this file for dev environment secrets." >> ./.env
    grep -q '.env' ./.gitignore || echo ".env" >> ./.gitignore
fi