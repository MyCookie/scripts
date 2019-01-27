#!/bin/bash

echo "Checking for open files"
echo ""

# fuser should check for applications with files open in the specified path
# dump the output, we don't need to show it unless there is an application
if fuser -m "/data" &> /dev/null; then
    fuser -mv /data
else
    DATA_OK=1
fi

if [[ $DATA_OK = 1 ]]; then
    echo "OK to unmount drives"
    echo ""
    echo "Unmounting drives"
    echo ""
    sudo umount /dev/mapper/data
    sudo cryptsetup close data
else
    echo ""
    echo "Unable to unmount drives"
fi

