#!/bin/bash

# Check if ncat is installed
if command -v ncat >/dev/null 2>&1; then
    echo -e "\e[1;32mncat is already installed.\e[0m"
else
    echo -e "\e[1:32mncat is not installed. Installing...\e[0m"
    sudo apt update
    sudo apt install -y ncat
fi

echo -e "\e[1;3;36mSelect 1 for receiver\e[0m"
echo -e "\e[1;3;36mSelect 2 for sender\e[0m"

read -p "Enter option [1-2]: "  option

case $option in

1)

read -p "Enter the port number to start Listner: " PORT
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
;;

2)

read -p "Enter target IP: " TARGET_IP
read -p "Enter target port: " TARGET_PORT

#Select the option to send data

echo -e "\e[1;31mWhat you want to transfer?\e[0m"
echo -e "\e[1;33m[1] Command Output\e[0m"
echo -e "\e[1;33m[2] File Transfer\e[0m"
echo -e "\e[1;33m[3] Image File\e[0m"
echo -e "\e[1;33m[4] Ram Acquisition File\e[0m"


read -p "Enter option [1-4]: " choice

case $choice in

#For transferring Command output
1)
echo -e "\e[1;34mEnter commands to send. Type 'exit' or 'quit' to stop.\e[0m"

while true; do
    read -e -p "> " CMD
    if [[ "$CMD" == "exit" || "$CMD" == "quit" ]]; then
        echo "Exiting."
        break
    fi

# Print locally
    echo "$CMD"

    # Prepare combined block with command and output
    {
echo -e "\n\e[1;32m----------------------Output of Command: $CMD-----------------------------\e[0m\n"
    } | ncat "$TARGET_IP" "$TARGET_PORT"


if [[ "$CMD" == "history" ]]; then
        cat ~/.bash_history | ncat "$TARGET_IP" "$TARGET_PORT"
   else

    # Run silently just to check if command succeeds
         $CMD > /dev/null 2>&1
        status=$?


 if [ $status -eq 0 ]; then
        # Command succeeded, run again and send output & errors
        $CMD 2>&1 | ncat "$TARGET_IP" "$TARGET_PORT"
    else
        # Command failed, send failure message
        echo "❌ Command failed to execute!" | ncat "$TARGET_IP" "$TARGET_PORT"
    fi


fi

done
;;


#For transferring File

2)
echo -e "\e[1;34mEnter files to send. Type 'exit' or 'quit' to stop.\e[0m"

while true; do
    read -e -p "> " FILENAME
    if [[ "$FILENAME" == "exit" || "$FILENAME" == "quit" ]]; then
        echo "Exiting."
        break
        else
        ncat "$TARGET_IP" "$TARGET_PORT" < $FILENAME
        fi
#    fi
done
# Print locally
    echo "$FILENAME"

;;


3)
echo -e "\e[1;34mEnter source to create image. Type 'exit' or 'quit' to stop.\e[0m"

read -e -p "> " IMAGE_SOURCE
    if [[ "$IMAGE_SOURCE" == "exit" || "$IMAGE_SOUTCE" == "quit" ]]; then
        echo "Exiting."
        break
    fi

dd if=$IMAGE_SOURCE | ncat $TARGET_IP $TARGET_PORT
;;

4)
echo -e "\e[1;34mEnter Memory Image file name (without extension). Type 'exit' or 'quit' to stop.\e[0m"

read -e -p "> " MEMORY_SOURCE
    if [[ "$MEMORY_SOURCE" == "exit" || "$MEMORY_SOURCE" == "quit" ]]; then
        echo "Exiting."
        break
    fi

# Step 1: Search entire filesystem for any executable named 'avml'
echo "Searching system for 'avml' binary..."
AVML_PATH=$(find / -type f -name "avml" -perm /111 -print 2>/dev/null | head -n 1)

# Step 2: If found, use it
if [ -n "$AVML_PATH" ]; then
    echo "Found avml at: $AVML_PATH"
AVML_DIR=$(dirname "$AVML_PATH")
cd $AVML_DIR
else
    echo "avml not found. Downloading..."
wget https://github.com/microsoft/avml/releases/download/v0.14.0/avml
chmod +x avml
fi

echo -e "\e[1;34mExecuting avml to capture memory\e[0m" ; ./avml $MEMORY_SOURCE.mem && echo -e "\e[1;34mTransferring file to receiver machine\e[0m" ; ncat $TARGET_IP $TARGET_PORT < $MEMORY_SOURCE.mem && rm $MEMORY_SOURCE.mem
;;

*)
    echo "❌ Invalid option selected."
    exit 1
    ;;

esac


esac

