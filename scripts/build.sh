#!/bin/bash
# Builds the packages in the repository

# Change the current working directory ($PWD) to the root of the
# repository to ensure this script always behaves consistently
cd $(git rev-parse --show-toplevel)

# Import common variables and functions
source ./scripts/common.sh

# Set step variables
step_cur=0
step_max=2

step "Building Framework..."
  npm run build --prefix ./Framework | trim
pets

step "Building Samples..."
  npm run build --prefix ./Samples/Samples/TypeScript/Demo | trim
pets
