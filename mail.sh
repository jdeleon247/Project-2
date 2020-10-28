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

checkParameters()
{
while [ "$1" != "" ]; do
    case $1 in
        -f | --file )           shift
                                filename=$1
                                ;;
        -i | --interactive )    interactive=1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done
}
checkGroup()
{
   if ! grep -q $group /etc/group   
   then
      echo "creating group "$group 
      groupadd $group
   fi
}

checkEmails()
{
   for user in $(cat emails.txt | cut -d "@" -f 1); 
   do randompw=$(openssl rand -base64 32); 
      if ! id $user &>/dev/null; then
         echo "${user}: user not found"
      fi 
   
   echo $user:$randompw
   done
}

errorExit()
{
   echo "$1" 1>&2
   exit 1
}

#Main

if [ $# -eq 0 ]; then
    echo "No arguments provided"
    exit 1
fi

if [ ! -f "$2" ]; then 
   echo "$2 does not exist"
   exit 1
fi

checkParameters
checkRoot
checkGroup
checkEmails
