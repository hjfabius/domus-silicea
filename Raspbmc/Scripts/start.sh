sudo initctl stop xbmc
sudo initctl start xbmc
sudo /etc/init.d/lirc restart
irsend SEND_ONCE yamaha SCENE_3
echo 'as' | /opt/xbmc-bcm/xbmc-bin/bin/cec-client -s