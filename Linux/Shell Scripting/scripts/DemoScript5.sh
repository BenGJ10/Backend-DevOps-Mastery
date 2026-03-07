#!/bin/bash

echo "Enter a number:"
read num

if (( $num <= 0 )); 
then
  echo "Please enter a positive integer."
  exit 1
fi

count=0

while (( $num > 0 ));
do  
    echo "$num second(s) remaining to stop this process..."
    sleep 1

    num=$((num-1))
    count=$((count+1))
done

echo
echo "Process stopped after $count second(s)."