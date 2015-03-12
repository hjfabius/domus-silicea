#! /usr/bin/env python
# tweetpic.py take a photo with the Pi camera and tweet it by Alex Eames http://raspi.tv/?p=5918
import tweepy 
from subprocess import call 
from datetime import datetime

API_KEY = 'gcnKD4srZDya2BWHGdjkeRC6F'
API_SECRET = 'HFDI4d4HEQzyATYToXTJIEKm66LJB3pTIhfdAXppx3JvmNfhWb'
ACCESS_TOKEN = '3074705164-SSioQCWL8G72KEIOlAeO0MVLriRDu18i6fcXhsn'
ACCESS_TOKEN_SECRET = 'fak4oZHQLQyZAmpNoproIZEjpP6tut20V0brAI8n92iMf'

auth = tweepy.OAuthHandler(API_KEY, API_SECRET)
auth.set_access_token(ACCESS_TOKEN, ACCESS_TOKEN_SECRET)
api = tweepy.API(auth)

 
i = datetime.now() #take time and date for filename 
now = i.strftime('%Y%m%d-%H%M%S') 
photo_name = now + '.jpg' 
cmd = 'raspistill -t 500 -w 1024 -h 768 -o /home/pi/' + photo_name 
call ([cmd], shell=True) #shoot the photo
# Send the tweet with photo
photo_path = '/home/pi/' + photo_name 
status = 'Photo auto-tweet from Pi: ' + i.strftime('%Y/%m/%d %H:%M:%S') 
api.update_with_media(photo_path, status=status)
