#!/bin/bash

# Script to run newt using values from .env file as command-line parameters

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo "Error: .env file not found!"
    echo "Please copy env.template to .env and fill in your values."
    exit 1
fi

# Source the .env file
source .env

# Check if required variables are set
if [ -z "$NEWT_ID" ] || [ -z "$NEWT_SECRET" ] || [ -z "$PANGOLIN_ENDPOINT" ]; then
    echo "Error: Required environment variables are not set in .env file!"
    echo "Please ensure NEWT_ID, NEWT_SECRET, and PANGOLIN_ENDPOINT are defined."
    exit 1
fi

echo "Starting newt with configuration from .env file..."
echo "Endpoint: $PANGOLIN_ENDPOINT"
echo "Newt ID: $NEWT_ID"
echo "Secret: ${NEWT_SECRET:0:8}..." # Show only first 8 characters for security

# Run newt with command-line parameters from .env variables
newt --id "$NEWT_ID" \
     --secret "$NEWT_SECRET" \
     --endpoint "$PANGOLIN_ENDPOINT" \
     --log-level DEBUG 