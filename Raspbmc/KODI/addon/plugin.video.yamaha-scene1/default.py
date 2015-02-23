import xbmc
import xbmcplugin
import xbmcaddon
import os

__addon__       = xbmcaddon.Addon(id='plugin.video.yamaha-scene1')
__addonname__   = __addon__.getAddonInfo('name')
__icon__        = __addon__.getAddonInfo('icon')

title = "Yamaha Remote"
text = "SCENE 1"
time = 5000  # ms

xbmc.executebuiltin('Notification(%s, %s, %d, %s)'%(title, text, time, __icon__))

os.system("irsend SEND_ONCE yamaha POWER_ON");
xbmc.sleep(500);
os.system("irsend SEND_ONCE yamaha SCENE_1");
xbmcplugin.endOfDirectory(int(sys.argv[1]))