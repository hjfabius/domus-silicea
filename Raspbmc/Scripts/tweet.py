#! /usr/bin/env python
import tweepy
from datetime import datetime

API_KEY = 'gcnKD4srZDya2BWHGdjkeRC6F'
API_SECRET = 'HFDI4d4HEQzyATYToXTJIEKm66LJB3pTIhfdAXppx3JvmNfhWb'
ACCESS_TOKEN = '3074705164-SSioQCWL8G72KEIOlAeO0MVLriRDu18i6fcXhsn'
ACCESS_TOKEN_SECRET = 'fak4oZHQLQyZAmpNoproIZEjpP6tut20V0brAI8n92iMf'

auth = tweepy.OAuthHandler(API_KEY, API_SECRET)
auth.set_access_token(ACCESS_TOKEN, ACCESS_TOKEN_SECRET)
api = tweepy.API(auth)

thetime = datetime.now().strftime('%-I:%M%P on %d-%m-%Y')

api.update_status(status="My first message at  " + thetime)
