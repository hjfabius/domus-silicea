import xbmc
import xbmcplugin
import xbmcaddon
import os

__addon__       = xbmcaddon.Addon(id='plugin.video.dell-off')
__addonname__   = __addon__.getAddonInfo('name')
__icon__        = __addon__.getAddonInfo('icon')

title = "Dell Remote"
text = "POWER OFF"
time = 5000  # ms

xbmc.executebuiltin('Notification(%s, %s, %d, %s)'%(title, text, time, __icon__))

os.system("net rpc shutdown -I 192.168.0.20 -U username%password  -t 1");
xbmcplugin.endOfDirectory(int(sys.argv[1]))
