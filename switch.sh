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
break;;
* ) echo -e '\033[31mPlease select 1 or 2\033[0m';;
esac
done
sh -c 'exec /etc/init.d/nginx start'
echo -e '\033[32mComplete\033[0m'
else
echo -e '\033[31mMainsail has not been installed.\033[0m'
fi