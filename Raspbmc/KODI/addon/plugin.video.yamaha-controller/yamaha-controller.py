import xbmc
import xbmcaddon
import xbmcgui
import os


__addon__       = xbmcaddon.Addon(id='plugin.video.yamaha-controller')
__addonname__   = __addon__.getAddonInfo('name')
__icon__        = __addon__.getAddonInfo('icon')

title = "Yamaha Controller"
text = "DISPLAY"
time = 5000  # ms

xbmc.executebuiltin('Notification(%s, %s, %d, %s)'%(title, text, time, __icon__))

# os.system("irsend SEND_ONCE yamaha DISPLAY");


# line1 = "This is a simple example of OK dialog"
# line2 = "Showing this message using"
# line3 = "XBMC python modules"
# 
# xbmcgui.Dialog().ok(__addonname__, line1, line2, line3)

#os.system("irsend SEND_ONCE yamaha POWER_ON");
#os.system("irsend SEND_ONCE yamaha SCENE_3");

#ActivateWindow(Videos,videodb://movies/titles/);

#os.system("irsend SEND_ONCE yamaha POWER_OFF");

