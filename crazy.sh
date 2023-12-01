#!/bin/bash

# Text lines to be displayed
lines=("Crazy?"
       "I was crazy once."
       "They locked me in a room."
       "A rubber room."
       "A rubber room with rats."
       "And rats make me crazy.")

# Infinite loop
while true
do
  # Loop through each line
  for line in "${lines[@]}"
  do
    echo "$line"   # Display the current line
    #read -r  # Wait for Enter key press without prompt
  done
done
sudo 