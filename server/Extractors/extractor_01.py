#!/usr/bin/python3
#-*- coding:utf-8 -*-
'''
该类已经测试过，可以很好的提取如下链接中的文章:
# OK!
http://www.xiejiaxin.com/?post=[X]	【short.lst文件中】
http://www.365essay.com/?post=[X]	【short.lst文件中】
# Not OK!

'''
import base_extractor
from core_ex_func import *
import lxml.html as H
from lxml.html.clean import Cleaner
import pickle
import json

class SinglePage(base_extractor.SinglePage):
	"""SinglePage for 365essay"""

	@staticmethod
	def __del_something_spec(doc):
		all_p = doc.findall('.//p')
		for p in all_p:
			if p.text == '标签:':
				p.drop_tree()
		all_div = doc.findall('.//div')
		for div in all_div:
			if div.text!=None and div.text.find('Designed By   版权所')>0:
				div.drop_tree()

	@staticmethod
	def rawTopure(raw_html):
		# 大规模清理html文本
		clnr = Cleaner(
			scripts=True,
			javascript=True,
			comments=True,
			style=True,
			links=True,
			meta=True, 
			page_structure=True,
			processing_instructions=True,
			embedded=True,
			frames=True,
			forms=True,
			annoying_tags=True,
			kill_tags=['a','title','head','span','small','img','font','label','li','ul','h1','h2','h3','h4'],
			remove_tags=['center','strong','td','tr'],
			safe_attrs_only=True,
			safe_attrs=[])
		raw_html = clnr.clean_html(raw_html).decode('utf-8').replace('</br>','<br>').replace('<br>','\n\n')
		# 使用lxml.html构建doc
		doc = H.fragment_fromstring(raw_html)
		# 处理标签尾
		deal_with_tail(doc,['div','p','table','body'])
		# 删除空白标签
		del_blank_tag(doc,['div','p','table'],whatever_blank=True)
		# 删除文字过少的标签
		del_few_text_tag(doc,['table','div'],20)
		# 删除一些特定的元素
		SinglePage.__del_something_spec(doc)
		# 删除冗余标签
		del_redunc_tag(doc,['div','p','table'])
		# 遴选得只包含正文的div
		doc = select_content_div(doc)
		# 转换Bytes串并打印或返回
		result = H.tostring(doc, pretty_print=True, method="html", encoding='utf-8')
		return result

	@staticmethod
	def digTitle(raw_html):
		doc = H.document_fromstring(raw_html)
		h = doc.findall('.//h1')
		if h:
			return  h[0].text
		else:
			h = doc.findall('.//title')[0].text.replace('- 天天美文网','')
			if h.find('：')>0:
				return h.split('：')[1]
			else:
				return h
		
	@staticmethod
	def digAuthor(pure_xml):
		doc = H.document_fromstring(pure_xml)
		p_list = doc.findall('.//p')
		for p in p_list:
			if p.text.startswith('作者:'):
				return p.text.split(':')[1].strip()
			elif p.text.startswith('作者：'):
				return p.text.split('：')[1].strip()
			else:
				return 'Null'

		
if __name__ == '__main__':
	file_obj = open('../URL_Lists/short.lst','rb')
	url_list = pickle.load(file_obj)
	i = 0
	for url in url_list:
		D = {}
		s =  SinglePage(url)
		D['TITLE'] = s.getTitle()
		D['AUTHOR'] = s.getAuthor()
		D['SOURCE'] = s.getPickingSource()
		D['PickingTime'] = s.getPickingTime()
		D['CONTENT'] = s.getPureXml(autodecode=False)
		output = open('../JSON_Files/short/'+str(i), 'wb')
		pickle.dump(D, output)
		output.close()
		output = open('../JSON_Files/short/'+str(i)+'.xml', 'w')
		output.write(D['CONTENT'].decode('utf-8'))
		output.close()
		print("写入文件'%s'成功" %str(i))
		i = i+1
	file_obj.close()
