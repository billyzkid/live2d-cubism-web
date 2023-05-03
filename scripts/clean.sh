#!/bin/bash
# Removes the build output from the repository

# Change the current working directory ($PWD) to the root of the
# repository to ensure this script always behaves consistently
cd $(git rev-parse --show-toplevel)

# Delete the build output folder
# Reference: https://git-scm.com/docs/git-clean
git clean -x --force --force --quiet ./out
