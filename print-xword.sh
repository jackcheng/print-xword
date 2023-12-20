#!/bin/bash

# Your NYT Cookie
NYT_COOKIE=""

# Filenames for the newest puzzle
URL_ROOT="https://www.nytimes.com/svc/crosswords/v2/puzzle/print"
FILENAME="$(date -v+1d +"%b%d%y").pdf"
TODAY_FILENAME="$(date +"%b%d%y").pdf"

# First make sure the cookie isn't blank
if [ -z "$NYT_COOKIE" ]; then
    echo "Your NYT_COOKIE can't be blank."
else
    # Assemble URL for tomorrow's crossword
    CROSSWORD_URL="$URL_ROOT/$FILENAME"

    # Size check to determine if tomorrow's crossword is out yet
    SIZE_CHECK=$(curl -s -r 0-499 "$CROSSWORD_URL" -b "$NYT_COOKIE")
    if [ ${#SIZE_CHECK} -gt 500 ]; then
        echo "Tomorrow's crossword is out! Printing it ..."
    else
        echo "Tomorrow's crossword isn't out yet. Printing today's ..."
        CROSSWORD_URL="$URL_ROOT/$TODAY_FILENAME"
    fi
    
    # Download and print
    curl "$CROSSWORD_URL" -b "$NYT_COOKIE" | lpr -o media=Letter -o fit-to-page
    # Or use the below line you'd like to download the file without printing:
    # curl -s "$CROSSWORD_URL" -b "$NYT_COOKIE" -o "/your-download-path/$FILENAME"
fi
