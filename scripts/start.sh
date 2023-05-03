#!/bin/bash
# Starts the packages in the repository

# Change the current working directory ($PWD) to the root of the
# repository to ensure this script always behaves consistently
cd $(git rev-parse --show-toplevel)

# Import common variables and functions
source ./scripts/common.sh

# Set step variables
step_cur=0
step_max=1

step "Starting TypeScript Demo..."
  npm run start --prefix ./Samples/Samples/TypeScript/Demo | trim
  start http://localhost:5000/Samples/TypeScript/Demo/
pets
