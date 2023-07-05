#!/bin/sh
NEW_HOSTNAME=$1
OLD_HOSTNAME=`cat /etc/hostname`

#Colours
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

#test if using sudo, ask if needed
SUDO=''
if (( $EUID != 0 )); then
SUDO='sudo'
fi

#if hostname not specified ask
if
[[ $NEW_HOSTNAME == "" ]]; then
echo -e "Your old hostname is ${BLUE}$OLD_HOSTNAME${NC}"
read -p "Please enter your new hostname: " NEW_HOSTNAME
fi

echo -e "Changing hostname from ${BLUE}$OLD_HOSTNAME${NC} to ${GREEN}$NEW_HOSTNAME${NC}"
echo ""

for file in hosts hostname
do
echo -e "Changed file: ${GREEN}/etc/$file${NC}"
$SUDO sed -i "s/$OLD_HOSTNAME/$NEW_HOSTNAME/" "/etc/$file"
done

echo ""
echo -e "Please ${RED}reboot${NC} to take affect"
