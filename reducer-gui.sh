#!/bin/bash


#ctrl c
trap ctrl_c INT
ctrl_c() {
echo -e "\n"
zenity --question --text "Are you sure you want to quit?" --no-wrap --ok-label "Yes" --cancel-label "No"
if [ $? = 0 ] ; then
echo "Thank you use video-size-reducer-gui"
exit 
fi
}


# spinner
spinlong ()
{
    bar=" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    barlength=${#bar}
    i=0
    while ((i < 100)); do
        n=$((i*barlength / 100))
        printf "\e[00;32m\r[%-${barlength}s]\e[00m" "${bar:0:n}"
        ((i += RANDOM%5+2))
        sleep 0.02
    done
    echo -e "[${green}OK${tp}]"
}
#checks

if [[ $(command -v zenity) = "" ]] ; then
    echo "Downloading Zenity.."
    sudo apt install zenity &> /dev/null
    sudo dnf install zenity &> /dev/null
    sudo pacman -S zenity &> /dev/null
    spinlong 
    sleep 1 
    clear 
    echo "Starting Video-Size-Reducer"
else
    echo "Starting Video-Size-Reducer"
    sleep 1
    clear 
fi

if [[ $(command -v ffmpeg) = "" ]] ; then 
   echo "Downloading ffmpeg"
   sudo apt install ffmpeg &> /dev/null 
   sudo dnf install ffmpeg &> /dev/null 
   sudo pacman -S ffmpeg &> /dev/null 
   spinlong 
   sleep 1 
   clear 
else 
echo ""
sleep 1 
clear 
fi



sec=$(zenity --file-selection --title "Select your video! [mp4]")

if [[ ${sec} =~ ^(exit|EXIT|EXİT|exıt) ]] ; then
        exit 0
    elif [[ ${sec} = "" ]] ; then
        zenity --warning \
        --text="No File Selected"
        echo "Exiting"
        exit 1
    fi

cats=$(ffmpeg -i $sec -vcodec libx264 -crf 24 output.mp4 &> /dev/null) 
if [[ `zenity --question --text "Are you sure?"; echo $?` -eq 0 ]]; then spinlong 
spinlong 
sleep 1 
clear
   echo "Saved On $PWD"
else
    echo "Failed..."
    sh
fi



 