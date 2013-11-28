#!/usr/bin/python3
# -*- coding: utf-8 -*- 

from cacher import Cacher
from core_func import *

def showArticle():
	D = cc.out_of_drawer()
	print('文章标题:'+D['TITLE'])
	print('文章作者:'+D['AUTHOR'])
	print('文章来源:'+D['SOURCE'])
	print('采集时间:'+D['PickingTime'])
	print('正文内容:'+D['CONTENT'].decode('utf-8'))
	return D

def showMenu():
	print('[1]文章点赞（Vote）\t[2]文章分享（Share）\t[3]文章保存（Save）\n\
		[4]文章评论（Remark）\t[5]邮件反馈（Email）\t[ENTER]下一篇')
	cmd = input('请输入指令(Q退出):')
	return cmd



cc = Cacher()
cc.start()
input('\t欢迎使用简致阅读\n\t按任意件开启阅读')

D = showArticle()
cmd = showMenu()
while True:
	if cmd=='Q':
		break
	elif cmd=='1':
		pass
	elif cmd=='2':
		pass
	elif cmd=='3':
		pass
	elif cmd=='4':
		pass
	elif cmd=='5':
		pass
	elif cmd=='':
		D = showArticle()
	else:
		print('指令错误请重新输入!')
	cmd = showMenu()

cc.stop()
print('感谢使用！')



