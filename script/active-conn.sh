#!/bin/sh

# From: http://cheesehead-techblog.blogspot.nl/2012/09/dbus-tutorial-fun-with-network-manager.html

# What network am I on?

# Get the Active Connection path
# Result should be like: /org/freedesktop/NetworkManager/ActiveConnection/187
active_connection_path=$( dbus-send --system --print-reply \
                          --dest=org.freedesktop.NetworkManager \
                          /org/freedesktop/NetworkManager \
                          org.freedesktop.DBus.Properties.Get \
                          string:"org.freedesktop.NetworkManager" \
                          string:"ActiveConnections" \
                          | grep ActiveConnection/ | cut -d'"' -f2 )

# Get the Access Point path
# Result should be like: /org/freedesktop/NetworkManager/AccessPoint/194
access_point_path=$( dbus-send --system --print-reply \
                     --dest=org.freedesktop.NetworkManager \
                     "$active_connection_path" \
                     org.freedesktop.DBus.Properties.Get \
                     string:"org.freedesktop.NetworkManager.Connection.Active" \
                     string:"SpecificObject" \
                     | grep variant | cut -d'"' -f2 )

# Get the Access Point ESSID
# Result should be something like "NETGEAR"
essid=$( dbus-send --system --print-reply \
                   --dest=org.freedesktop.NetworkManager \
                   "$access_point_path" \
                   org.freedesktop.DBus.Properties.Get \
                   string:"org.freedesktop.NetworkManager.AccessPoint" \
                   string:"Ssid" \
                   | grep variant | cut -d'"' -f2 )



echo "ESSID: $essid"
# If we are on the HOME network
#if [ "$essid"=="MyHomeNet" ]; then
   # Do network-specific changes here

#elif [ "$essid"=="WorkCorporateNet" ]
   # Do network-specific changes here

#else
   # Do changes for unrecognized network or no network at all here

#fi
exit 0
