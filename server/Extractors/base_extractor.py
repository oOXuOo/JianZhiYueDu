#!/usr/bin/python3
#-*- coding:utf-8 -*-

from abc import ABCMeta,abstractmethod
import time
import urllib.request 

class SinglePage(object,metaclass=ABCMeta):
	"""一个页面对应一个SinglePage"""
	def __init__(self, arg):
		super(SinglePage, self).__init__()
		self.__src_url = arg
		self.__src_html = self.getRawHtml()

	@staticmethod
	@abstractmethod
	def rawTopure(raw_html):
		pass
	@staticmethod
	@abstractmethod
	def digTitle(raw_html):
		pass
	@staticmethod
	@abstractmethod
	def digAuthor(raw_html):
		pass


	def getRawHtml(self, autodecode=False):
		if '_SinglePage__src_html' in self.__dict__:
			if autodecode:
				return self.__src_html.decode('GBK')
			else:
				return self.__src_html
		else:
			try:
				# Try To Make Connection
				req = urllib.request.Request(self.__src_url, headers={'User-Agent' : "Magic Browser"})
				res = urllib.request.urlopen(req)
				# Try To Get Html
				# The Return Value is a Bytes(coded in GBK) in Python3
				return res.read()
			except Exception:
				raise ValueError('类初始URL:%s\t无效' %self.__src_url)				
	def getPureXml(self, autodecode=False):
		if '_SinglePage__pure_xml' in self.__dict__:
			if autodecode:
				return self.__pure_xml.decode('utf-8')
			else:
				return self.__pure_xml
		else:
			# From raw_html To pure_xml
			self.__pure_xml = self.rawTopure(self.__src_html) 
			# The Default Return Value is a Bytes(coded in UTF-8) in Python3  
			if autodecode:
				return self.__pure_xml.decode('utf-8')
			else:
				return self.__pure_xml
	def getTitle(self):
		if '_SinglePage__title' in self.__dict__:
			return self.__title
		else:
			# Dig Article Title from Raw HTML
			self.__title = self.digTitle(self.__src_html)
			return self.__title
	def getAuthor(self):
		if '_SinglePage__author' in self.__dict__:
			return self.__author
		else:
			# Dig Article Author from Pure_xML
			self.__author = self.digAuthor(self.getPureXml(autodecode=True))
			return self.__author
	def getPickingSource(self, simplify=False):
		if simplify:
			return urllib.parse.urlparse(self.__src_url).hostname
		else:
			return self.__src_url	
	def getPickingTime(self):
		# Have to Import time Module
		return time.strftime('%Y-%m-%d',time.localtime(time.time()))


if __name__ == '__main__':
	s =  SinglePage('http://www.365essay.com/sanwen008/108.htm')
	print(s.getPickingSource(simplify=True))
	