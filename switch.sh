#!/bin/sh

if [ -e '/usr/share/mainsail' ]; then
if [[ $(sh -c 'exec /etc/init.d/nginx status') == *"running"* ]]; then
sh -c 'exec /etc/init.d/nginx stop'
fi
while true; do
read -p "$(printf '\r\n\r\n\033[33mSelect Web UI Type?\r\n\r\n\033[36m1: Fluidd\r\n2: Mainsail\r\n\r\n\033[0m')" resp
case $resp in
[1]* ) 
echo -e '\033[32mUsing Fluidd as the Web UI\r\n\033[0m'
sed -i 's^root /usr/share/mainsail^root /usr/share/fluidd^g' /etc/nginx/nginx.conf
break;;
[2]* ) 
echo -e '\033[32mUsing Mainsail as the Web UI\r\n\033[0m'
sed -i 's^root /usr/share/fluidd^root /usr/share/mainsail^g' /etc/nginx/nginx.conf
if [ ! -e '/usr/share/moonraker/utils' ]; then
while true; do
read -p "$(printf '\r\n\r\n\033[33mThe default Moonraker is being used, the camera will not be available with this version\r\nWould you like to use the version that enables the camera?\r\n\r\n\033[36m(Y|N)?: \033[0m')" res
case $res in
[Yy]* ) 
if [[ $(sh -c 'exec /etc/init.d/moonraker status') == *"running"* ]]; then
sh -c 'exec /etc/init.d/moonraker stop'
fi
if [ ! -e '/usr/share/moonraker_backup' ]; then
echo "Backup original 'moonraker' to 'moonraker_backup'"
mv /usr/share/moonraker /usr/share/moonraker_backup
fi
if [ -e '/usr/share/moonraker' ]; then
rm -r /usr/share/moonraker
fi
echo -e '\033[32mInstalling Moonraker\033[0m'
cp -r ~/K2-Mainsail-main/moonraker /usr/share/moonraker
sh -c 'exec /etc/init.d/moonraker start'
break;;
[Nn]* ) 
echo -e '\033[35mThe current Moonraker install has not been changed\033[0m'
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
fi
break;;
* ) echo -e '\033[31mPlease select 1 or 2\033[0m';;
esac
done
sh -c 'exec /etc/init.d/nginx start'
echo -e '\033[32mComplete\033[0m'
else
echo -e '\033[31mMainsail has not been installed.\033[0m'
fi
