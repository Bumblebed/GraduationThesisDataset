import requests
from bs4 import BeautifulSoup
import pandas as pd
import time
import os
os.environ["NO_PROXY"]="www.onetonline.org"

url=r"https://www.onetonline.org/link/summary/41-2011.00"
response=requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')

where_1=soup.getText().find('Occupation-Specific Information\nTasks')
where_2=soup.getText().find('Find occupations related to')

txt=soup.getText()[where_1:where_2]
print(txt)

lst=txt.split('\n')
lst=list(set(lst))
lst.remove('Related occupations')
len(lst)

all_jobs=pd.read_excel(r"D:\小论文&毕业论文\职业可替代风险\All_Job_Families.xlsx")
my_dict={}
for i in all_jobs["Code"]:
    url=f"https://www.onetonline.org/link/summary/{i}"
    try:
        response=requests.get(url,headers = {'User-agent': 'your bot 0.1'},timeout=(5, 10),verify=False)
        soup = BeautifulSoup(response.text, 'html.parser')
        content=soup.getText()
    
        where_1=content.find('Occupation-Specific Information\nTasks')
        where_2=content.find('Find occupations related to')
        txt=content[where_1:where_2]

        if txt!='':

            lst=txt.split('\n')
            lst=list(set(lst))
            lst.remove('Related occupations')
            my_dict[i]=lst
            print(f"{i} ready!")
    except requests.exceptions.ReadTimeout as e:
        print(e)

my_dict_copy=my_dict
df1=pd.DataFrame({'code':list(my_dict_copy.keys()),'tasks':list(my_dict_copy.values())})
df1.to_csv(r"D:\小论文&毕业论文\职业可替代风险\tasks.csv")

#request the abilities
import numpy as np
skills=pd.read_excel(r"C:\Users\Bumbl\Downloads\Skills.xlsx")
folder_path = r"D:\小论文&毕业论文\职业可替代风险\skills"

my_dict={}
for i in np.unique(skills["Element ID"]).tolist():
    url=f"https://www.onetonline.org/find/descriptor/result/{i}"
    try:
        response=requests.get(url,headers = {'User-agent': 'your bot 0.1'},timeout=(5, 10),verify=False)
        soup = BeautifulSoup(response.content, 'html.parser')
        link = soup.find("a", {"class": "ms-2"}).get("href")
        excel_url = url + link
        excel_response = requests.get(excel_url)
        file_name = excel_url.split("/")[-1].replace('?fmt=xlsx','')
        with open(folder_path + "\\"+file_name, "wb") as f:
            f.write(excel_response.content)
        
        print(f"{i} ready!")
    except requests.exceptions.ReadTimeout as e:
        print(e)

my_dict_copy=my_dict
df1=pd.DataFrame({'code':list(my_dict_copy.keys()),'tasks':list(my_dict_copy.values())})
df1.to_csv(r"D:\小论文&毕业论文\职业可替代风险\tasks.csv")

