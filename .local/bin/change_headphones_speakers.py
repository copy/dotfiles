#!/usr/bin/python3
import subprocess
import os

profile_test = b"active profile: <output:analog-surround-51+input:analog-stereo>"

test = subprocess.check_output(["pacmd", " list-cards"])

if profile_test in test:
    os.system("notify-send Headphones")
    os.system("pactl set-card-profile alsa_card.pci-0000_00_1b.0 output:analog-stereo+input:analog-stereo")
    os.system("amixer -c 1 set 'Auto-Mute Mode' 'Enabled'")
else:
    os.system("notify-send Speakers")
    os.system("pactl set-card-profile alsa_card.pci-0000_00_1b.0 output:analog-surround-51+input:analog-stereo")
    os.system("amixer -c 1 set 'Auto-Mute Mode' 'Disabled'")
