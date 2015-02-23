import xbmc
import xbmcplugin
import xbmcaddon
import os

__addon__       = xbmcaddon.Addon(id='plugin.video.dell-on')
__addonname__   = __addon__.getAddonInfo('name')
__icon__        = __addon__.getAddonInfo('icon')

title = "Dell Remote"
text = "POWER ON"
time = 5000  # ms

xbmc.executebuiltin('Notification(%s, %s, %d, %s)'%(title, text, time, __icon__))

os.system("sudo etherwake F0:4D:A2:AE:F7:ED");
xbmcplugin.endOfDirectory(int(sys.argv[1]))