#!/bin/bash

###########################
# Author  : Vishal Kumar. S
# Version : v1
# Date:   : 31-08-2023
# This project is used to retrieve information from GitHub using API calls
###########################

# Check if the required number of arguments is provided
if [ ${#@} -lt 2 ]; then
	    echo "Usage: $0 [GitHub token] [REST API expression]"
	        exit 1;
fi

# Store the provided arguments in variables
GITHUB_TOKEN=$1
GITHUB_REST_API=$2

# Define the header for the GitHub API request
GITHUB_API_HEADER_ACCEPT="Accept: application/vnd.github.v3+json"

# Create a temporary file to store the API response
TMPFILE=$(mktemp /tmp/github-api-response.XXXXXXX) || exit 1

# Function to make a REST API call using curl
function rest_call {
	    curl -s -H "${GITHUB_API_HEADER_ACCEPT}" -H "Authorization: token $GITHUB_TOKEN" "$1" >> "$TMPFILE"
    }

    # Make the API call and store the response in the temporary file
    rest_call "https://api.github.com${GITHUB_REST_API}"

    # Display the contents of the temporary file
    cat "$TMPFILE"

