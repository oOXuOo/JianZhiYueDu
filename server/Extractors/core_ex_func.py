#!/usr/bin/python3
#-*- coding:utf-8 -*-

import lxml.html as H


def _count_chr_in_list(str_list):
    total = 0
    for html_string in str_list:
        html_string_without_n = html_string.replace('\n','').strip()
        total += len(html_string_without_n) 
    return total
def _get_all_text_count_in_tag(tag):
    all_text = tag.xpath('.//text()')
    total = _count_chr_in_list(all_text)
    return total

def select_content_div(soup):
	while True:
		chld_list = soup.getchildren()
		if len(chld_list)>=1 and chld_list[0].tag=='div':
			soup = chld_list[0]
		else:
			break
	return soup
			
def deal_with_tail(soup,taglist):
	for name in taglist:
		all_tag = soup.findall('.//'+name)
		while True:
			tag_count = len(all_tag)
			for tag in all_tag:
				if tag.tail!=None:
					if tag.tail.strip()=='':
						tag.tail=None
					else:
						tag.text = tag.text+tag.tail
			all_tag = soup.findall('.//'+name)
			if tag_count == len(all_tag):
				break

def del_blank_tag(soup,taglist,whatever_blank=False):
	for name in taglist:
		all_tag = soup.findall('.//'+name)
		while True:
			tag_count = len(all_tag)
			for tag in all_tag:
				if tag.getchildren()==[]:
					if tag.text==None :
						tag.drop_tree()    
					elif tag.text.strip()=='' :
						tag.drop_tree()
					elif whatever_blank:
						tag.text = tag.text.strip()
				else:
					if tag.text!=None:
						tmp = tag.text.strip()
						if tmp=='':
							tag.text = None
						elif whatever_blank:
							tag.text = tmp
			all_tag = soup.findall('.//'+name)
			if tag_count == len(all_tag):
				break

def del_redunc_tag(soup,taglist):
	for name in taglist:
		all_tag = soup.findall('.//'+name)
		while True:
			tag_count = len(all_tag)
			for tag in all_tag:
				if len(tag.getchildren())==1 :
					# print(H.tostring(tag, pretty_print=True, method="html", encoding='utf-8').decode('utf-8'))
					# print('xxxxxxxx')
					tag.drop_tag()      
			all_tag = soup.findall('.//'+name)
			if tag_count == len(all_tag):
				break

def del_few_text_tag(soup,taglist,threshold):
	for name in taglist:
		all_tag = soup.findall('.//'+name)
		for tag in all_tag:
			if _get_all_text_count_in_tag(tag)<threshold*3:
				tag.drop_tree()

