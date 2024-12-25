import re
from PyPDF2 import PdfReader
import pandas as pd
import numpy as np

# 打开 PDF 文件并创建一个 PdfFileReader 对象
with open('9.中华人民共和国职业分类大典（2015版）（供参考）.pdf', "rb") as file:
    pdf_reader = PdfReader(file)

    # 提取每一页中的文本内容并存储到列表中
    text_list = []
    for page_num in range(len(pdf_reader.pages)):
        page = pdf_reader.pages[page_num]
        text_list.append(page.extract_text())

# 使用正则表达式从文本列表中找出匹配 X-XX-XX 格式的字符串，并保存到结果列表中
pattern = r"\d-\d{2}-\d{2}"
result_list = []
for text in text_list:
    matches = re.findall(pattern, text)
    result_list.extend(matches)

#前面的字符串为特定字符串，后面字符串为换行符的任意长度的字符串
def find_string_after_keyword(text, keyword):
    pattern = r"(?<={}).*?(?=\n)".format(re.escape(keyword))
    match = re.search(pattern, text)
    if match:
        return match.group(0).strip()
    else:
        return None

#前面的字符串为特定字符串，后面字符串为换行符的任意长度的字符串
def find_string_after_keyword(text, keyword):
    pattern = r"(?<=\b" + re.escape(keyword) + r")[^\n]*"
    matches = re.findall(pattern, text)
    return matches

#从一个字符串中去除所有的非中文字符
def remove_non_chinese_characters(text):
    pattern = r"[^\u4e00-\u9fff]+"  # 匹配非中文字符的模式
    result = re.sub(pattern, "", text)
    return result

#在一个文本中查找所有符合特定格式的字符串（五个字符均为 0-9 的数字）
def find_custom_format_strings(text):
    pattern = r"\b\d{5}\b"  # 匹配指定格式字符串的模式
    matches = re.findall(pattern, text)
    return matches

#在文本中查找符合 "X-XX-XX-XX" 格式的字符串（其中 X 为数字）
def find_custom_format_strings(text):
    pattern = r"\b\d-\d{2}-\d{2}-\d{2}\b"  # 匹配指定格式字符串的模式
    matches = re.findall(pattern, text)
    return matches

#找到每个细类与其名称
d4list=[]
for text in text_list:
    d4list+=find_custom_format_strings(text)
d4list=list(set(d4list))

d4dict={}
for d4 in d4list:
    d4name=[]
    for text in text_list:
        matches=find_string_after_keyword(text,d4)
        for i in range(len(matches)):
            matches[i]=remove_non_chinese_characters(matches[i])
        matches=list(set(matches))
        d4name+=matches
    if len(d4name)>1:
        maxlen=d4name[0]
        for name in d4name:
            if len(name)>len(maxlen):
                maxlen=name
        d4name=maxlen
    elif len(d4name)>0:
        d4name=d4name[0]
        
    d4dict[d4]=d4name

#找到所有的gbm五位职业
gbm_list=[]
for text in text_list:
    gbm_list+=find_custom_format_strings(text)
gbm_list=list(set(gbm_list))

#匹配每个GBM编码和对应的职业名称
oc_dict={}
for gbm in gbm_list:
    oc_list=[]
    for text in text_list:
        matches=find_string_after_keyword(text,gbm)
        if matches!=None:
            for i in range(len(matches)):
                matches[i]=remove_non_chinese_characters(matches[i])
                
            oc_list+=list(set(matches))

    oc_dict[gbm]=oc_list

#对职业名称列表去重
for gbm in gbm_list:
    oc_dict[gbm]=list(set(oc_dict[gbm]))
    if '' in oc_dict[gbm]:
        oc_dict[gbm].remove('')

# 输出结果列表中所有满足条件的字符串值    
len(oc_dict.keys())
pd.DataFrame(result_list).to_excel(r"COCO15.xlsx")
pd.DataFrame({'gbm':oc_dict.keys(),'oc':oc_dict.values()}).to_excel("oc_dict.xlsx")
pd.DataFrame({'d4':d4dict.keys(),'name':d4dict.values()}).to_excel("d4dict.xlsx")
