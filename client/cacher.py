#!/usr/bin/python3
# -*- coding: utf-8 -*- 

'''
zhangxu
blabla
.........
'''
import time
import pickle
import _thread
import threading
from random import randint

class Cacher(threading.Thread):
	"""docstring for Cacher"""
	def __init__(self, enable_autoinit=True):
		super(Cacher, self).__init__()
		# 缓存器的几个状态变量
		self.__TopLayerState = None
		self.__BtmLayerState = None
		self.__DrawerState = None
		self.__DrawerOpenable = None
		# 上下层的球
		self.__TopBall = {}
		self.__BtmBall = {}
		# 自销毁（生存）状态
		self.__Existance = True

	def __initCacher(self):
		self.__cacheTopLayer()
		self.__BtmBall = self.__TopBall
		self.__TopBall = None
		self.__cacheTopLayer()
		self.__TopLayerState = 'FULL'
		self.__BtmLayerState = 'FULL'
		self.__DrawerState = 'CLOSED'

	def __cacheTopLayer(self):
		file_obj = open('../server/JSON_Files/short/'+str(randint(1,400)),'rb')
		self.__TopBall = pickle.load(file_obj)
		file_obj.close()
		# 这句至关重要
		self.__TopLayerState = 'FULL'

	def out_of_drawer(self):
		if self.__DrawerOpenable:
			# 防止极快的连续抽取，让还在半空中的球完成自由落体
			while not self.__BtmBall:
				pass
			self.__DrawerState = 'OPEN'
			tmp = self.__BtmBall
			self.__BtmBall = None
			self.__BtmLayerState = 'EMPTY'
			self.__DrawerState = 'CLOSED'
			return tmp
		else:
			print('Caching Now... Cannot Open Drawer >.<')
			return False

	def run(self):
		'''
		此方法为异步方法，将自动开辟一个新的线程，
		建立一个新的Cache实例后就应该随即调用该方法：
		Cache().start()
		'''
		self.__initCacher()
		while self.__Existance:
			# 一切工作均在抽屉关闭时进行
			if self.__DrawerState == 'CLOSED':
				# 先考虑底层
				if self.__BtmLayerState=='FULL':
					self.__DrawerOpenable = True
				else:
					self.__DrawerOpenable = False
					if self.__TopLayerState=='FULL':
						# 重力效果 -- 顶层球落入底层
						self.__BtmBall = self.__TopBall
						self.__TopBall = None
						self.__BtmLayerState = 'FULL'
						self.__TopLayerState = 'EMPTY'
				# 再考虑顶层
				if self.__TopLayerState=='FULL':
					pass
				else:
					# 为保证立等可取的效果，此处应非阻塞
					_thread.start_new_thread(self.__cacheTopLayer, ())
			# 已经打开 -- 不能再打开
			else:
				self.__DrawerOpenable = False

	def stop(self):
		self.__Existance = False

if __name__ == '__main__':
	cc = Cacher()
	cc.start()
	time.sleep(1)
	print('1111111111111111111111111111111111111111')
	D = cc.out_of_drawer()
	print(D)
	print('22222222222222222222222222222222222222222')
	D = cc.out_of_drawer()
	print(D)
	print('33333333333333333333333333333333333333333')
	D = cc.out_of_drawer()
	print(D)
	print('44444444444444444444444444444444444444444')
	D = cc.out_of_drawer()
	print(D)
	cc.stop()
