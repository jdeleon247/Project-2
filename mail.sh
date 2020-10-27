#!/bin/bash

group="CSI230"
checkRoot()
{
   if [[ $EUID -ne 0 ]]; 
      then
      echo "This script must be run as root" 
      exit 1
   fi
}

checkGroup()
{
   if grep -q $group /etc/group   
   then
      echo "group exists"
   else
      echo "creating group "$group 
      groupadd $group
   fi
}
#Main

checkRoot
checkGroup
