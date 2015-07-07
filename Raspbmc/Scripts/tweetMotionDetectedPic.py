#!/usr/bin/env python2.7  
# twitterwin.py by Alex Eames http://raspi.tv/?p=5281  
import tweepy  
import random  
from datetime import datetime
  
# Consumer keys and access tokens, used for OAuth  
API_KEY = 'gcnKD4srZDya2BWHGdjkeRC6F'
API_SECRET = 'HFDI4d4HEQzyATYToXTJIEKm66LJB3pTIhfdAXppx3JvmNfhWb'
ACCESS_TOKEN = '3074705164-SSioQCWL8G72KEIOlAeO0MVLriRDu18i6fcXhsn'
ACCESS_TOKEN_SECRET = 'fak4oZHQLQyZAmpNoproIZEjpP6tut20V0brAI8n92iMf'

auth = tweepy.OAuthHandler(API_KEY, API_SECRET)
auth.set_access_token(ACCESS_TOKEN, ACCESS_TOKEN_SECRET)
api = tweepy.API(auth)


strTime = datetime.now().strftime('%Y/%m/%d %H:%M:%S') 

photo_path = '/home/pi/easyiot/download.jpg'
status = 'Photo auto-tweet from Pi: ' + strTime

#image_ids = api.update_with_media(photo_path, status=status)
image_ids = api.update_with_media(photo_path)

api.send_direct_message("hjfabius", image_ids)

