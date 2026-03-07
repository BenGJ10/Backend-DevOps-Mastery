#!/bin/bash

echo "Choose from the following options:"
echo "1. Display the current date and time"
echo "2. List files in the current directory"
echo "3. Display the current user's username"
echo "4. Check System uptime"
echo "5. Exit"

echo
echo -n "Enter your choice (1-5): "
read choice

case $choice in 

    1) echo "Current date and time: $(date)";;
    2) echo "Files in the current directory:"; ls -l;;
    3) echo "Current user's username: $(whoami)";;
    4) echo "System uptime: $(uptime)";;
    5) echo "Exiting..."; exit 0;;
    *) echo "Invalid choice. Please enter a number between 1 and 5.";;
esac

