#!/bin/bash

#this shell script is to clone repo update the file & push the changes made
#author : Vikas 
#written on : 14th-Apr-2023



country=""
env_name=""
reason=""


while [[ ! $country =~ ^(kenya|rwanda)$ ]]; do
    echo "Please enter country name (kenya/rwanda) "
    read -p "Enter a country name: " country
done

while [[ ! $env_name =~ ^(prod|stage)$ ]]; do
    echo "Please enter environment (prod/stage) "
    read -p "Please enter environment : " env_name
done

while [[ -z $reason ]]; do
    echo "please enter the reason,please do not keep reason blank"
    read -p "reason : " reason
done


country=$country
env=$env_name
commit_reason=$reason

if [ -d "db-management" ]; then
  cd db-management

  echo "Repository already exist locally, pulling latest changes from remote repository"

  git pull origin main
  cd ../db-management/var/${country}/${env}/

else
  # clone the repository

echo "Cloning remote repository to local !"

sleep 2

  git clone git@github.com:vikaswadile/db-management.git
  cd db-management/var/${country}/${env}/
fi


echo "--------------------------------------------------"
echo "Below is the present working directory"
echo "--------------------------------------------------"

pwd

#listing files present in the directory
sleep 1
echo "--------------------------------------------------"
echo "Below are the files present in repository" 
echo "--------------------------------------------------"

ls -1p | grep -v / | awk '{print $1}'

# prompt the user for the file to update
file_names=""

sleep 1
echo "--------------------------------------------------"
while [[ -z $file_names ]]; do
    echo "Enter file name (if multiple files please enter names space separated): "
    read -p "reason : " file_names
done
echo "--------------------------------------------------"

opened_files=()

for file_name in $file_names
do
    if [ -f "$file_name" ]; then
sleep 1	    
echo "---------------------------------------------------"
echo "please wait while opening $file_name in vi editor."
echo "---------------------------------------------------"
sleep 1

        vim "$file_name"

echo "---------------------------------------------------"
echo "file $file_name is updated & saved succesfully."
echo "---------------------------------------------------"
sleep 1

if [ $? -eq 0 ]; then
	
	opened_files+=("$file_name")

fi

    else

sleep 1
echo "File $file_name does not exist"
sleep 1
    fi
done


message="${opened_files[@]}"


# git difference

echo "---------------------------------------------------"
git status
echo "---------------------------------------------------"

echo "---------------------------------------------------"
git diff
echo "---------------------------------------------------"


choice=""

while [[ ! $choice =~ ^(yes|no)$ ]]; do
    echo "Please enter your choice in yes or no"
    read -p "Above changes looks good to you? (yes/no): " choice	
done



# Check if the user wants to proceed or not
if [ "$choice" == "yes" ] || [ "$choice" == "Yes" ]; then
    # Proceed with the steps here

# commit the changes

git add *
git commit -m "Updated $message : Reason--> $commit_reason"

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

  fi

    # more steps here
else
    # Exit the script if the user does not want to proceed
    cd ../../../../
    rm -rf db-management
    echo "Exiting the script..."
    exit 1
fi
