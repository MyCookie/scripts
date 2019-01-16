#!/bin/bash

# remove all wine extensions
rm -rf $HOME/.local/share/applications/wine-extension*.desktop
rm -rf $HOME/.local/share/icons/hicolor/*/*/application-x-wine-extension*

# remove the old mime cache
rm -rf $HOME/.local/share/applications/mimeinfo.cache
rm -rf $HOME/.local/share/mime/packages/x-wine*
rm -rf $HOME/.local/share/mime/application/x-wine-extension*

# update the cache
update-desktop-database $HOME/.local/share/applications
update-mime-database $HOME/.local/share/mime

echo "export WINEDLLOVERRIDES=\"winemenubuilder=d\"" >> $HOME/.bashrc
