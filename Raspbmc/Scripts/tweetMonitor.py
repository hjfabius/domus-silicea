#!/usr/bin/env python2.7  
# twitterwin.py by Alex Eames http://raspi.tv/?p=5281  
import tweepy  
import random  
  
# Consumer keys and access tokens, used for OAuth  
API_KEY = 'gcnKD4srZDya2BWHGdjkeRC6F'
API_SECRET = 'HFDI4d4HEQzyATYToXTJIEKm66LJB3pTIhfdAXppx3JvmNfhWb'
ACCESS_TOKEN = '3074705164-SSioQCWL8G72KEIOlAeO0MVLriRDu18i6fcXhsn'
ACCESS_TOKEN_SECRET = 'fak4oZHQLQyZAmpNoproIZEjpP6tut20V0brAI8n92iMf'

auth = tweepy.OAuthHandler(API_KEY, API_SECRET)
auth.set_access_token(ACCESS_TOKEN, ACCESS_TOKEN_SECRET)
api = tweepy.API(auth)  
  

#follow2 = api.followers() # gives a list of followers ids  

#print "you have %d followers" % len(follow2)  
#print follow2[0].screen_name
#print follow2[0].id
#print follow2[0].user_id  

user = api.get_user('hjfabius')
print user.screen_name


print len(api.direct_messages())
