# SM FFPLAY/FFMPEG Freechat Recorder v.1.0.1 by horacio9a for Python 2.7.13

import sys, os, urllib, requests, json, ssl, re, time, datetime, command
from websocket import create_connection
from colorama import init, Fore, Back, Style
from termcolor import colored
import ConfigParser
config = ConfigParser.ConfigParser()
config.read('config.cfg')

init()
print(colored(" => START <= ", 'yellow', 'on_blue'))
print

while True:
   try:
      modellist = open(config.get('files', 'model_list'),'r')
      for (num,value) in enumerate(modellist):
         print ' =>',(num+1),value[:-1]
      print
      mn = int(raw_input(colored(" => Select SM Model => ", 'yellow', 'on_blue')))
      print
      break
   except ValueError:
      print
      print(colored(" => Input must be a number <=", 'yellow', 'on_red'))
      print
model = open(config.get('files', 'model_list'), 'r').readlines()[mn-1][:-1]
print (colored(' => Selected SM Model => {} <=', 'yellow', 'on_blue')).format(model)
print

modelinfo = requests.get("https://streamate.com/ajax/config/?name={}&sakey=&sk=streamate.com&userid=0&version=2.3.1&ajax=1".format(model)).json()

if modelinfo['stream']['serverId'] != '0':
 url = modelinfo['stream']['nodeHost'] + "/socket.io/?performerid=" + str(
      modelinfo['performer']['id']) + "&sserver=" + modelinfo['stream']['serverId'] + "&streamid=" + \
         modelinfo['stream']['streamId'] + "&sakey=&sessiontype=preview&perfdiscountid=0&minduration=0&goldshowid=0&version=7&referrer=hybrid.client.2.3.1%2Favchat.swf&usertype=false&EIO=3&transport=websocket"
 ws = create_connection(url)
 i = 0
 while i < 5:
  result = ws.recv()
  i = i + 1
  if "roomid" in result:
   result = json.loads(result[2:])[1]
   roomInfo = result['data'][22]
   videourl = ('https:' + requests.utils.quote(
   '//sea1b-ls.naiadsystems.com/sea1b-hub-api/8101/videourl') + '?' + requests.utils.quote(
   'payload') + '=' + requests.utils.quote('{"puserid":"' + str(modelinfo['performer']['id']) + '","roomid":"' + roomInfo[
   'roomid'] + '","showtype":1,"nginx":1}'))
   videoinfo = requests.get(videourl).json()
   try:
     videoinfo = requests.get(videoinfo[0]['url']).json()
   except:
     print(colored(" => Model is in PVT or BUSY <=", "yellow",'on_red'))
     print
     print(colored(" => END <=", "yellow","on_blue"))
     sys.exit()
   hlsurl = videoinfo['formats']['mp4-hls']['manifest']
   print (colored(' => hlsurl => {} <=', 'yellow', 'on_blue')).format(hlsurl)
   timestamp = str(time.strftime("%d%m%Y-%H%M%S"))
   stime = str(time.strftime("%H:%M:%S"))
   path = config.get('folders', 'output_folder')
   filename = model + '_SM_' + timestamp + '.flv'
   pf = (path + filename)
   ffplay = config.get('files', 'ffplay')
   ffmpeg = config.get('files', 'ffmpeg')

   while True:
      try:
         print
         mode = int(raw_input(colored(" => Select mode REC(1) or PLAY(0) => ", "yellow", "on_blue")))
         break
      except ValueError:
         print(colored("\n => Input must be a number <=", "yellow", "on_red"))
   if mode == 0:
      mod = 'PLAY'
   if mode == 1:
      mod = 'REC'

   if mod == 'PLAY':
      print
      print (colored(" => FF PLAY => {} <=", "yellow", "on_magenta")).format(filename)
      print
      command = ('{} -hide_banner -loglevel panic -i {} -infbuf -autoexit -window_title "{} * {} * {}"'.format(ffplay,hlsurl,model,stime,mn))
      os.system(command)
      print(colored(" => END <=", "yellow","on_blue"))
      sys.exit()

   if mod == 'REC':
      print
      print (colored(" => FF REC => {} <=", "yellow", "on_red")).format(filename)
      command = ('{} -hide_banner -loglevel panic -i {} -c:v copy -c:a aac -b:a 160k {}'.format(ffmpeg,hlsurl,pf))
      os.system(command)
      print
      print(colored(" => END <=", "yellow","on_blue"))
      sys.exit()

else:
   print(colored(" => Model is OFFLINE <=", 'yellow','on_red'))
   print
   print(colored(" => END <= ", 'yellow','on_blue'))
   sys.exit()
