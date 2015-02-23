import xbmc
import xbmcplugin
import xbmcaddon
import os

__addon__       = xbmcaddon.Addon(id='plugin.video.yamaha-5+1')
__addonname__   = __addon__.getAddonInfo('name')
__icon__        = __addon__.getAddonInfo('icon')

title = "Yamaha Remote"
text = "5+1 MOVIE"
time = 5000  # ms

xbmc.executebuiltin('Notification(%s, %s, %d, %s)'%(title, text, time, __icon__))

os.system("irsend SEND_ONCE yamaha EQ_MOVIE");
xbmcplugin.endOfDirectory(int(sys.argv[1]))