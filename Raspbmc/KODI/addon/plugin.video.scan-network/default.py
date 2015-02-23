import xbmc
import xbmcgui
import xbmcaddon
import os
import subprocess 
import xbmcplugin

__addon__       = xbmcaddon.Addon(id='plugin.video.scan-network')
__addonname__   = __addon__.getAddonInfo('name')
__icon__        = __addon__.getAddonInfo('icon')

title = "Network Scanner"
time = 5000  # ms


try:

		#p = subprocess.Popen("arp-scan -l | grep 64:20:0c:3d:76:f7", stdout=subprocess.PIPE)
		p = subprocess.Popen(["sudo", "arp-scan", "-l"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
		output, err = p.communicate()
		#if output:
		#	text = output
		#	#text = "HJ_PAD connected to HJ_HOME"
		#else:
		
		#text = "No known devices connected to HJ_HOME"
		
		text = " "
		
		if output.find("f0:4d:a2:ae:f7:ed") != -1:
			print "HJ_DELL connected to HJ_HOME"
			text = text + "HJ_DELL,"
			listItem = xbmcgui.ListItem("HJ_DELL connected to HJ_HOME")
			xbmcplugin.addDirectoryItem(int(sys.argv[1]),"plugin://plugin.script.test", listItem)

		
		if output.find("80:86:f2:90:84:1d") != -1:
			print "PMICHNEUL11253 connected to HJ_HOME"
			text = text + "PMICHNEUL11253,"
			listItem = xbmcgui.ListItem("PMICHNEUL11253 connected to HJ_HOME")
			xbmcplugin.addDirectoryItem(int(sys.argv[1]),"plugin://plugin.script.test", listItem)
        
		if output.find("64:20:0c:3d:76:f7") != -1:
			print "HJ_PAD connected to HJ_HOME"
			text = text + "HJ_PAD,"
			listItem = xbmcgui.ListItem("HJ_PAD connected to HJ_HOME")
			xbmcplugin.addDirectoryItem(int(sys.argv[1]),"plugin://plugin.script.test", listItem)
			
		if output.find("0c:74:c2:bf:b2:79") != -1:
			print "EA_PHONE connected to HJ_HOME"
			text = text + "EA_PHONE,"
			listItem = xbmcgui.ListItem("EA_PHONE connected to HJ_HOME")
			xbmcplugin.addDirectoryItem(int(sys.argv[1]),"plugin://plugin.script.test", listItem)
		
		if output.find("00:f4:b9:50:90:6a") != -1:
			print "HJ_PHONE connected to HJ_HOME"
			text = text + "HJ_PHONE,"
			listItem = xbmcgui.ListItem("HJ_PHONE connected to HJ_HOME")
			xbmcplugin.addDirectoryItem(int(sys.argv[1]),"plugin://plugin.script.test", listItem)
		 
		if output.find("18:9e:fc:2f:75:5d") != -1:
			print "AG_PHONE connected to HJ_HOME"
			text = text + "AG_PHONE,"		
			listItem = xbmcgui.ListItem("AG_PHONE connected to HJ_HOME")
			xbmcplugin.addDirectoryItem(int(sys.argv[1]),"plugin://plugin.script.test", listItem)
		
		#if text = "" :
		#	text = "No known devices connected to HJ_HOME" 
		
		
except Exception as e:
	title = title + " - Exception"
	text = str(e)

		

xbmc.executebuiltin('Notification(%s, %s, %d, %s)'%(title, text, time, __icon__))

xbmcplugin.endOfDirectory(int(sys.argv[1]))