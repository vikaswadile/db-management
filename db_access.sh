#!/bin/bash

#this shell script is to clone repo update the file & push the changes made
#author : Vikas 
#written on : 14th-Apr-2023

# check if the repository is already present
if [ -d "db-management" ]; then
  cd db-management/var/prod/
  # pull the latest changes from the remote branch

echo "Repository already exist locally, pulling latest changes from remote repository"

  git pull origin main

else
  # clone the repository

echo "Cloning remote repository to local !"

sleep 2

  git clone git@github.com:vikaswadile/db-management.git
  cd db-management/var/prod/
fi

#listing files present in the directory
sleep 2
echo "--------------------------------------------------"
echo "Below are the files present in repository"
echo "--------------------------------------------------"

ls -1p | grep -v / | awk '{print $1}'

# prompt the user for the file to update
sleep 2
echo "--------------------------------------------------"
read -p "Enter the name of the file you want to update: " file_name
echo "--------------------------------------------------"
sleep 2

# edit the file

echo "---------------------------------------------------"
echo "you have selected $file_name,please wait opening vi editor for you."
echo "---------------------------------------------------"
sleep 2

vi $file_name

echo "---------------------------------------------------"
echo "file $file_name is updated & saved succesfully."
echo "---------------------------------------------------"
sleep 2


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
sleep 2

git add $file_name

echo "---------------------------------------------------"
echo "commting the changes you made"
echo "---------------------------------------------------"

sleep 2

read -p "write the suitable comment to commit the file : " comment

git commit -m "$comment"

# push the changes to the remote branch
sleep 2
echo "---------------------------------------------------"
echo "Pushing changes to the remote repository"
echo "---------------------------------------------------"

git push origin main



echo "----------------------------------------------------"
echo "Your changes pushed succesfully to the remote repo"
echo "----------------------------------------------------"



    # more steps here
else
    # Exit the script if the user does not want to proceed
    cd ../../../
    rm -rf db-management
    echo "Exiting the script..."
    exit 1
fi
