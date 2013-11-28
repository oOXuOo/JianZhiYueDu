#!usr/bin/python3
# -*-coding:utf-8-*-

import urllib2
import pickle


url_list = []
for j in range(1,9):
	for i in range(1,500):
		url = 'http://www.365essay.com/sanwen%03d/%03d.htm' %(j,i)
		# Send Request To Website Server
		req = urllib2.Request(url, headers={'User-Agent' : "Magic Browser"})
		try:
			# Try To Get Response
			res = urllib2.urlopen(req,timeout=5)
		except:
			print('打开URL:%s错误\t已丢弃' %url) 
			continue
		else:
			try:
				html = res.read()
			except:
				print('打开URL:%s错误\t已丢弃' %url) 
				continue
			else:
				if html.find("<meta http-equiv='refresh' content='1; url=http://www.365essay.com/'>")>0:
					print('跳转页:%s\t已丢弃' %url) 
					break
				else:
					url_list.append(url)
output = open('../URL_Lists/sanwen.lst', 'w')
pickle.dump(url_list, output)