#!usr/bin/python3
# -*-coding:utf-8-*-

import urllib2
import pickle


url_list = []
for i in range(1,404):
	url = 'http://www.xiejiaxin.com/?post='+str(i)
	# Send Request To Website Server
	req = urllib2.Request(url, headers={'User-Agent' : "Magic Browser"})
	try:
		# Try To Get Response
		res = urllib2.urlopen(req)
	except urllib2.HTTPError :
		print('打开URL:%s错误\t已丢弃' %url) 
		continue
	url_list.append(url)

for i in range(2,1903):
	url = 'http://www.365essay.com/?post='+str(i)
	# Send Request To Website Server
	req = urllib2.Request(url, headers={'User-Agent' : "Magic Browser"})
	try:
		# Try To Get Response
		res = urllib2.urlopen(req)
	except urllib2.HTTPError :
		print('打开URL:%s错误\t已丢弃' %url) 
		continue
	url_list.append(url)

output = open('../URL_Lists/short.lst', 'w')
pickle.dump(url_list, output)
output.close()