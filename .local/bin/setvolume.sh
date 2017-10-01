#!/bin/bash


SINKS=$(pactl list sinks|grep -oh 'Name: .*'|cut -d ' ' -f2)

CURVOL=$(pactl list sinks |grep "Volume:"|grep -v "Base"|grep -oh '\([0-9]*\)%'|tail -n1|tr % ' ')

echo Current volume: $CURVOL

MUTE=$(pactl list sinks|grep -oh 'Mute: \w*'|cut -b 7-10|tail -n1)
echo Muted: $MUTE

if [[ $1 == "increase" ]]
then
    CURVOL=$(($CURVOL - $CURVOL % 5 + 5))
    if [[ $CURVOL -ge 150 ]]
    then
        CURVOL=150
    fi
    notify-send $CURVOL
elif [[ $1 == "decrease" ]]
then
    CURVOL=$(($CURVOL - $CURVOL % 5 - 5))
    if [[ $CURVOL -le 0 ]]
    then
        CURVOL=0
    fi
    notify-send $CURVOL
elif [[ $1 == "mute" ]]
then
    if [[ $MUTE == "no" ]]
    then
        for SINK in $SINKS
        do
            pactl set-sink-mute $SINK 1
        done
        notify-send "Muted"
    exit
    else
        for SINK in $SINKS
        do
            pactl set-sink-mute $SINK 0
        done
        notify-send "Not muted"
    exit
    fi
fi

for SINK in $SINKS
do
    pactl set-sink-volume $SINK $CURVOL%
done
