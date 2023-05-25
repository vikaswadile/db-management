#!/bin/bash

#this shell script is to clone repo update the file & push the changes made
#author : Vikas 
#written on : 14th-Apr-2023


read -p "Please enter country (kenya/rwanda) :" country_name
read -p "Please enter environment (prod/stage) :" env_name

country=$country_name
env=$env_name
echo "--------------------------------------------------"
echo "Cloning remote repository to local !"
echo "--------------------------------------------------"
sleep 1

  git clone <url>
  cd db-management/var/${country}/${env}/

#listing files present in the directory
sleep 1
echo "--------------------------------------------------"
echo "Below are the files present in repository"
echo "--------------------------------------------------"

ls -1p | grep -v / | awk '{print $1}'

# prompt the user for the file to update
sleep 1
echo "--------------------------------------------------"
read -p "Enter the name of the file you want to update: " file_names
echo "--------------------------------------------------"
sleep 1

# edit the file

echo "---------------------------------------------------"
echo "you have selected $file_name,please wait opening vi editor for you."
echo "---------------------------------------------------"
sleep 1

for file in $file_names
do
vim $file
done


echo "---------------------------------------------------"
echo "file $file_name is updated & saved succesfully."
echo "---------------------------------------------------"
sleep 1


# git difference

echo "---------------------------------------------------"
git status
echo "---------------------------------------------------"

echo "---------------------------------------------------"
git diff
echo "---------------------------------------------------"

read -p "Above changes looks good to you? (yes/no): " choice

# Check if the user wants to proceed or not
if [ "$choice" == "yes" ] || [ "$choice" == "Yes" ]; then
    # Proceed with the steps here

# commit the changes
echo "---------------------------------------------------"
echo "performing git add step for file $file_name"
echo "---------------------------------------------------"
sleep 1

git add *

echo "---------------------------------------------------"
echo "commting the changes you made"
echo "---------------------------------------------------"

sleep 1

read -p "write the suitable comment to commit the file : " comment

git commit -m "$comment"

# push the changes to the remote branch
sleep 1
echo "---------------------------------------------------"
echo "Pushing changes to the remote repository"
echo "---------------------------------------------------"

git push origin main

#if push operation failed

if [ $? -ne 0 ]; then
    echo "---------------------------------------------------"
    echo "Push operation failed! The remote repository may have the latest changes and commits."
    echo "---------------------------------------------------"
    
        cd ../../../../
        rm -rf db-management    

    read -p "Do you want to re-execute this script to avoid conflicts? (yes/no): " retry_choice
    if [ "$retry_choice" == "yes" ] || [ "$retry_choice" == "Yes" ]; then
      exec "$0"
    else
      exit 1
    fi

  else
    echo "----------------------------------------------------"
    echo "Your changes were pushed successfully to the remote repository."
    echo "----------------------------------------------------"

    cd ../../../../
    rm -rf db-management    



  fi

    # more steps here
else
    # Exit the script if the user does not want to proceed
    cd ../../../../
    rm -rf db-management
    echo "Exiting the script..."
    exit 1
fi
