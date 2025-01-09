#!/bin/sh

if [ -e '/root/main.zip' ]; then
rm ~/main.zip
fi
if [[ $(sh -c 'exec /etc/init.d/moonraker status') == *"running"* ]]; then
sh -c 'exec /etc/init.d/moonraker stop'
fi
if [[ $(sh -c 'exec /etc/init.d/nginx status') == *"running"* ]]; then
sh -c 'exec /etc/init.d/nginx stop'
fi
if [ ! -e '/usr/share/moonraker_backup' ]; then
echo "Backup original moonraker to 'moonraker_backup'"
mv /usr/share/moonraker /usr/share/moonraker_backup
fi
if [ -e '/usr/share/moonraker' ]; then
while true; do
read -p "$(printf '\r\n\r\n\033[36mMoonraker install found, would you like to overwrite it?\r\n\r\n\033[36m(Y|N)?: \033[0m')" resp
case $resp in
[Yy]* ) 
rm -r /usr/share/moonraker
echo -e '\033[32mInstalling Moonraker\033[0m'
cp -r ~/K2-Mainsail-main/moonraker /usr/share/moonraker
break;;
[Nn]* ) 
echo -e '\033[35mThe current Moonraker install has not been changed\033[0m'
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
else
echo -e '\033[32mInstalling Moonraker\033[0m'
cp -r ~/K2-Mainsail-main/moonraker /usr/share/moonraker
fi
if [ -e '/usr/share/mainsail' ]; then
while true; do
read -p "$(printf '\r\n\r\n\033[36mMainsail install found, would you like to overwrite it?\r\n\r\n\033[36m(Y|N)?: \033[0m')" resp
case $resp in
[Yy]* ) 
echo -e '\033[32mInstalling Mainsail\033[0m'
rm -r /usr/share/mainsail
cp -r ~/K2-Mainsail-main/mainsail /usr/share/mainsail
break;;
[Nn]* ) 
echo -e '\033[35mThe current mainsail install has not been changed\033[0m'
break;;
* ) echo -e '\033[31mPlease answer Y or N\033[0m';;
esac
done
else	
echo -e '\033[32mInstalling Mainsail\033[0m'
cp -r ~/K2-Mainsail-main/mainsail /usr/share/mainsail
fi
echo "Install camera support..."
cp ~/K2-Mainsail-main/camera.html /usr/share/frontend/camera.html
cp ~/K2-Mainsail-main/snapshot.html /usr/share/frontend/snapshot.html
cp ~/K2-Mainsail-main/index.html /usr/share/frontend/index.html
cp ~/K2-Mainsail-main/favicon.ico /usr/share/frontend/favicon.ico
cp ~/K2-Mainsail-main/mylogo.png /usr/share/frontend/mylogo.png
cp ~/K2-Mainsail-main/camera.html /usr/share/mainsail/camera.html
cp ~/K2-Mainsail-main/snapshot.html /usr/share/mainsail/snapshot.html
echo -e '\033[33mChange Web UI to Mainsail\033[0m'
sed -i 's^root /usr/share/fluidd^root /usr/share/mainsail^g' /etc/nginx/nginx.conf
sed -i 's^/var/log/nginx/fluidd-access.log^/var/log/nginx/mainsail-access.log^g' /etc/nginx/nginx.conf
sed -i 's^/var/log/nginx/fluidd-error.log^/var/log/nginx/mainsail-error.log^g' /etc/nginx/nginx.conf
sh -c 'exec /etc/init.d/nginx start'
sh -c 'exec /etc/init.d/moonraker start'
echo -e '\033[32mComplete\033[0m'