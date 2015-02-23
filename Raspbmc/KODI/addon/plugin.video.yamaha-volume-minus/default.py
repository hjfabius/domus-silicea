import xbmc
import xbmcplugin
import xbmcaddon
import os

__addon__       = xbmcaddon.Addon(id='plugin.video.volume-minus')
__addonname__   = __addon__.getAddonInfo('name')
__icon__        = __addon__.getAddonInfo('icon')

title = "Yamaha Remote"
text = "VOLUME -"
time = 5000  # ms

xbmc.executebuiltin('Notification(%s, %s, %d, %s)'%(title, text, time, __icon__))

os.system("irsend SEND_ONCE yamaha VOLUME_DOWN");
xbmc.sleep(500);
os.system("irsend SEND_ONCE yamaha VOLUME_DOWN");
xbmc.sleep(500);
os.system("irsend SEND_ONCE yamaha VOLUME_DOWN");
xbmc.sleep(500);
os.system("irsend SEND_ONCE yamaha VOLUME_DOWN");
xbmc.sleep(500);
xbmcplugin.endOfDirectory(int(sys.argv[1]))