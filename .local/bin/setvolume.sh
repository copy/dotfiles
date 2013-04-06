#!/bin/bash


if [[ $1 == "increase" ]]
then
    amixer set Master 7%+
elif [[ $1 == "decrease" ]]
then
    amixer set Master 7%-
elif [[ $1 == "mute" ]]
then
    amixer set Master toggle
fi



exit
# pulseaudio method starts below
# this breaks in some cases, so back to amixer

#### Create ~/.pulse/mute if not exists
ls ~/.pulse/mute &> /dev/null
if [[ $? != 0 ]]
then
    echo "false" > ~/.pulse/mute
fi



####Create ~/.pulse/volume if not exists
ls ~/.pulse/volume &> /dev/null
if [[ $? != 0 ]]
then
    echo "65536" > ~/.pulse/volume
fi


#SINK=alsa_output.pci-0000_05_00.0.analog-surround-51
SINK=alsa_output.pci-0000_00_1b.0.analog-surround-51

CURVOL=`cat ~/.pulse/volume`     #Reads in the current volume
MUTE=`cat ~/.pulse/mute`          #Reads mute state

if [[ $1 == "increase" ]]
then
    CURVOL=$(($CURVOL + 3277)) #3277 is 5% of the total volume, you can change this to suit your needs.
    if [[ $CURVOL -ge 65536 ]]
    then
        CURVOL=65536        
    fi
elif [[ $1 == "decrease" ]]
then
    CURVOL=$(($CURVOL - 3277))
    if [[ $CURVOL -le 0 ]]
    then
        CURVOL=0        
    fi
elif [[ $1 == "mute" ]]
then
    if [[ $MUTE == "false" ]]
    then
        pactl set-sink-mute $SINK 1
        echo "true" > ~/.pulse/mute
    exit    
    else
        pactl set-sink-mute $SINK 0
        echo "false" > ~/.pulse/mute    
    exit
    fi
fi

pactl set-sink-volume $SINK $CURVOL
echo $CURVOL > ~/.pulse/volume # Write the new volume to disk to be read the next time the script is run.
