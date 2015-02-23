import xbmc
import xbmcplugin
import xbmcaddon
import os

__addon__       = xbmcaddon.Addon(id='plugin.video.yamaha-scene3')
__addonname__   = __addon__.getAddonInfo('name')
__icon__        = __addon__.getAddonInfo('icon')

title = "Yamaha Remote"
text = "SCENE 3"
time = 5000  # ms

os.system("echo 'as' | /opt/xbmc-bcm/xbmc-bin/bin/cec-client -s");
os.system("irsend SEND_ONCE yamaha POWER_ON");
xbmc.sleep(500);
os.system("irsend SEND_ONCE yamaha SCENE_3");
xbmcplugin.endOfDirectory(int(sys.argv[1]))

xbmc.executebuiltin('Notification(%s, %s, %d, %s)'%(title, text, time, __icon__))


