#!/bin/sh

if [[ $(sh -c 'exec /etc/init.d/moonraker status') == *"running"* ]]; then
sh -c 'exec /etc/init.d/moonraker stop'
fi
if [[ $(sh -c 'exec /etc/init.d/nginx status') == *"running"* ]]; then
sh -c 'exec /etc/init.d/nginx stop'
fi
echo -e '\033[32mRestoring Fluidd\033[0m'
sed -i 's^root /usr/share/mainsail^root /usr/share/fluidd^g' /etc/nginx/nginx.conf

if [ -e '/usr/share/moonraker_backup' ]; then
while true; do
read -p "$(printf '\r\n\r\n\033[36mWould you like to retore moonraker to the factory default version?\r\n\r\n\033[36m(Y|N)?: \033[0m')" resp
case $resp in
[Yy]* ) 
echo -e '\033[32mRestoring original moonraker\033[0m'
if [ -e '/usr/share/moonraker' ]; then
rm -r /usr/share/moonraker
fi
cp -r /usr/share/moonraker_backup /usr/share/moonraker
break;;
[Nn]* ) 
echo -e '\033[35mThe current Moonraker install has not been changed\033[0m'
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
fi
sh -c 'exec /etc/init.d/nginx start'
sh -c 'exec /etc/init.d/moonraker start'
echo -e '\033[32mComplete\033[0m'