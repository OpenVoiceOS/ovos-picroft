#!/bin/bash
# This needs to run as root

# Turn Off LEDs
sj201 reset-led red
# Set fan speed to 0
sj201 set-fan-speed 0
