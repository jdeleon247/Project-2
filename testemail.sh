#!/bin/bash

sendmail(){
echo "email test body" | s-nail -v -s "email test subject" "tillyboyd@protonmail.com"
}

#echo -e "test email script body" | s-nail -S smtp-use-starttls -S ssl-verify=ignore -S smtp-auth=login -S smtp="gmail.com:587" -S smtp-auth-user="jonathan.deleon@mymail.champlain.edu" -S smtp-auth-password="sjsuvtgzseisaytg" -r "jonathan.deleon@mymail.champlain.edu" -s "test email script header" -. "tillyboyd@protonmail.com"

export -f sendmail
su jonathandeleon -c "bash -c sendmail"
exit 0
