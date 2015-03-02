#!/bin/bash

# Simple script to link my Emacs config into my home
# directory. Creates a backup of the existing configuration.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo 'Linking .emacs.d'
mv ~/.emacs.d ~/.emacs.d.backup
ln -s $DIR/emacs.d ~/.emacs.d
