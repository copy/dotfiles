#!/bin/bash


#if [[ $1 == "increase" ]]
#then
#    #amixer set Master 7%+
#    amixer -c0 set Master 7%+
#    amixer -c1 set Master 7%+
#    amixer -c2 set Master 7%+
#elif [[ $1 == "decrease" ]]
#then
#    #amixer set Master 7%-
#    amixer -c0 set Master 7%-
#    amixer -c1 set Master 7%-
#    amixer -c2 set Master 7%-
#elif [[ $1 == "mute" ]]
#then
#    #amixer set Master toggle
#    amixer -c0 set Master toggle
#    amixer -c1 set Master toggle
#    amixer -c2 set Master toggle
#fi
#
#
#
#exit


# pulseaudio method starts below

#mkdir -p /tmp/.pulse/

#### Create /tmp/.pulse/mute if not exists
#ls /tmp/.pulse/mute &> /dev/null
#if [[ $? != 0 ]]
#then
#    echo "false" > /tmp/.pulse/mute
#fi

####Create /tmp/.pulse/volume if not exists
#ls /tmp/.pulse/volume &> /dev/null
#if [[ $? != 0 ]]
#then
    #echo "65536" > /tmp/.pulse/volume
#fi


# Find with: pactl list sinks|grep 'Name:'
#SINK=alsa_output.pci-0000_05_00.0.analog-surround-51
#SINK=alsa_output.pci-0000_00_1b.0.analog-surround-51
#SINK=alsa_output.pci-0000_00_1b.0.analog-surround-51
SINK=$(pactl list sinks|grep -oh 'Name: .*'|cut -d ' ' -f2|head -n1)

#CURVOL=`cat /tmp/.pulse/volume`     #Reads in the current volume
CURVOL=$(pactl list sinks |grep "Volume:"|grep -v "Base"|grep -oh '\([0-9]*\)%'|head -n1|tr % ' ')
echo Current volume: $CURVOL

#MUTE=`cat /tmp/.pulse/mute`          #Reads mute state
MUTE=$(pactl list sinks|grep -oh 'Mute: \w*'|cut -b 7-10)
echo Muted: $MUTE

if [[ $1 == "increase" ]]
then
    CURVOL=$(($CURVOL + 5))
    if [[ $CURVOL -ge 150 ]]
    then
        CURVOL=150
    fi
    notify-send $CURVOL
elif [[ $1 == "decrease" ]]
then
    CURVOL=$(($CURVOL - 5))
    if [[ $CURVOL -le 0 ]]
    then
        CURVOL=0
    fi
    notify-send $CURVOL
elif [[ $1 == "mute" ]]
then
    if [[ $MUTE == "no" ]]
    then
        pactl set-sink-mute $SINK 1
        notify-send "Muted"
    exit
    else
        pactl set-sink-mute $SINK 0
        notify-send "Not muted"
    exit
    fi
fi

pactl set-sink-volume $SINK $CURVOL%

#echo $CURVOL

#echo $CURVOL > /tmp/.pulse/volume # Write the new volume to disk to be read the next time the script is run.
