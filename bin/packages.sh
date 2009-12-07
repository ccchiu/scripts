#!/bin/sh
# backup
dpkg --get-selections > /tmp/packages
# restore
#dpkg --set-selections < /tmp/packages

# use dselect with "i" options
#dselect 
