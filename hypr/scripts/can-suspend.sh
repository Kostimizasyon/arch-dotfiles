#!/bin/bash

# Check AC power via battery status (Charging/Full = on AC)
bat_status=$(cat /sys/class/power_supply/BAT1/status 2>/dev/null)
on_ac=false
[ "$bat_status" = "Charging" ] || [ "$bat_status" = "Full" ] && on_ac=true

# Check for active SSH session
ssh_active=false
ss -tn state established '( sport = :ssh )' | grep -q . && ssh_active=true

# If either condition is true, exit non-zero (signals "retry")
if $on_ac || $ssh_active; then
    exit 1
else
    exit 0
fi
