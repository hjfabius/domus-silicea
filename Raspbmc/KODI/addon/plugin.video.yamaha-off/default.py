import xbmc
import xbmcplugin
import xbmcaddon
import os

__addon__       = xbmcaddon.Addon(id='plugin.video.yamaha-off')
__addonname__   = __addon__.getAddonInfo('name')
__icon__        = __addon__.getAddonInfo('icon')

title = "Yamaha Remote"
text = "POWER OFF"
time = 5000  # ms

xbmc.executebuiltin('Notification(%s, %s, %d, %s)'%(title, text, time, __icon__))

os.system("irsend SEND_ONCE yamaha POWER_OFF");
xbmcplugin.endOfDirectory(int(sys.argv[1]))