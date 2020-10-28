#!/bin/bash

group="CSI230"

checkRoot()
{
   if [ "$(id -u)" != "0" ]; then
    echo "You must be the superuser to run this script" >&2
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

addAccounts()
{
   for email in $(cat emails.txt);
   do user=$(cut -d "@" -f 1 <<< "$email")
      if id $user &>/dev/null; then
         echo "changing password for ${user}"
      fi
   randompw=$(openssl rand -base64 32);
   adduser --gecos "" --disabled-password $user &>/dev/null
   echo $user:$randompw | chpasswd
   chage -l $user >/dev/null
   sudo -u jonathandeleon bash << HereTag
   echo "Hello ${user}, your new password is ${randompw}" | s-nail -v -s "Login Credentials" $email &>/dev/null
HereTag
done
}

#Main

if [ $# -eq 0 ]; then
    echo "No arguments provided"
    exit 1
fi

if [ ! -f "$2" ]; then
   echo "file does not exist"
   exit 1
fi

checkParameters
checkRoot
checkGroup
addAccounts

