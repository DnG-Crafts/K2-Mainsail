# K2-Mainsail
Mainsail UI for the K2 Plus


#### This requires root access to be enabled on the printer.
<br>


Firmware updates may remove the changes so you may have to run the commands again after a firmware update.


<br>
<br>

[![https://www.youtube.com/watch?v=V9haiiDYiXg](https://img.youtube.com/vi/V9haiiDYiXg/0.jpg)](https://www.youtube.com/watch?v=V9haiiDYiXg)

https://www.youtube.com/watch?v=V9haiiDYiXg<br>



<hr>


## Install Commands
```sh
python -c "from six.moves import urllib; urllib.request.urlretrieve('https://github.com/DnG-Crafts/K2-Mainsail/archive/refs/heads/main.zip', '/root/main.zip')" 
python -c "import shutil; shutil.unpack_archive('/root/main.zip', '/root/')"
sh ~/K2-Mainsail-main/install.sh

```






<hr>

if you wish to restore the printer to its original configuration then run the commands below

## Restore Commands
```sh
sh ~/K2-Mainsail-main/restore.sh

```







<hr>

if you wish to switch between Fluidd or Mainsail and leave the installed files intact

## Switch UI Commands
```sh
sh ~/K2-Mainsail-main/switch.sh

```



