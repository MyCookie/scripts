#!/bin/bash

# Unmount any mapped crypt device if it follows the following 'spec':
# Name of the mapped device is shared with the folder it's mounted to.
# The folder resides in /

echo "Checking for open files on $1"
echo ""

# fuser should check for applications with files open in the specified path
# dump the output, we don't need to show it unless there is an application
if fuser -m "/$1" &> /dev/null; then
    fuser -mv /$1
else
    DATA_OK=1
fi

if [[ $DATA_OK = 1 ]]; then
    echo "OK to unmount $1"
    echo ""
    echo "Unmounting $1"
    echo ""
    sudo umount /dev/mapper/$1
    sudo cryptsetup close $1
else
    echo ""
    echo "Unable to unmount $1"
fi

