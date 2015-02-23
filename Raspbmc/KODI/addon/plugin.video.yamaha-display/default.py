import xbmc
import xbmcplugin
import xbmcaddon
import xbmcgui
import os

__addon__       = xbmcaddon.Addon(id='plugin.video.yamaha-display')
__addonname__   = __addon__.getAddonInfo('name')
__icon__        = __addon__.getAddonInfo('icon')

title = "Yamaha Remote"
text = "DISPLAY"
time = 5000  # ms


xbmc.executebuiltin('Notification(%s, %s, %d, %s)'%(title, text, time, __icon__))

os.system("irsend SEND_ONCE yamaha DISPLAY");
xbmcplugin.endOfDirectory(int(sys.argv[1]))
