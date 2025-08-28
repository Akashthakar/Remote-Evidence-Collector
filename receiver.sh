#!/bin/bash

# Check if ncat is installed
if command -v ncat >/dev/null 2>&1; then
    echo -e "\e[1;35mncat is already installed.\e[0m"
else
    echo -e "\e[1:35mncat is not installed. Installing...\e[0m"
    sudo apt update
    sudo apt install -y ncat
fi

read -p "Enter the port number to start Listner: " PORT
# read -p "Enter File Name to save output: " FILENAME
echo -e "\e[1;31mWhat you want to receive?\e[0m"
echo -e "\e[1;33m[1] Command output\e[0m"
echo -e "\e[1;33m[2] File Transfer\e[0m"
echo -e "\e[1;33m[3] Image File\e[0m"
echo -e "\e[1;33m[4] Ram Acquisition File\e[0m"

read -p "Enter option [1-4]: " choice

read -p "Enter File Name to save output (without extension): " FILENAME

case $choice in 

1)
 echo -e "\n\e[1;35mStoring command output in file $FILENAME.........\e[0m"

ncat -lvkp $PORT | tee -a $FILENAME
;;

2)
echo -e "\n\e[1;35mStoring file output in file $FILENAME.........\e[0m"
ncat -lvp $PORT > $FILENAME
;;

3)
echo -e "\n\e[1;35mStoring Image in file $FILENAME.........\e[0m"
ncat -lvp $PORT | dd of=$FILENAME.dd status=progress
;;

4)
echo -e "\n\e[1;35mStoring RAM Image file in $FILENAME.........\e[0m"
ncat -lvp $PORT > $FILENAME.mem
;;

*)
    echo "❌ Invalid option selected."
    exit 1
    ;;

esac

