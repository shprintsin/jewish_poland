import requests
all_links=[]

import requests
from bs4 import BeautifulSoup
from concurrent.futures import ThreadPoolExecutor

all_links = []
i=1
def fetch_links(i):
    base="https://ziemstwa.judaistyka.uj.edu.pl/en_GB/katalog-ziemstw?p_p_id=56_INSTANCE_Fb3kUEohfZD8&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&sortField=modifiedDate&sortOrder=DESC&strona="
    url = base + str(i)
    res = requests.get(url)
    soup = BeautifulSoup(res.text, 'html.parser')
    links = soup.find('div', class_='journal-content-article').find_all('a')
    links=[link.get('href') for link in links]
    print(i)

    return links

with ThreadPoolExecutor(max_workers=10) as executor:
    results = list(executor.map(fetch_links, range(1, 201)))

for result in results:
    all_links.extend(result)

for i, link in enumerate(all_links):
    print(f'{i}/{len(all_links)}')

import pandas as pd
pd.DataFrame(all_links).to_csv('all_links.csv',index=False)
all_data=[]
len(all_links)
for i,link in enumerate(all_links):
    res=requests.get(link)
    soup=BeautifulSoup(res.text,'html.parser')
    all_data.append(str(soup.find('div',id='tresc')))
    # print(link)
    print(f'{i}/{len(all_links)}')

from concurrent.futures import ThreadPoolExecutor
all_links=pd.read_csv('all_links.csv')
all_links=all_links['0'].to_list()
def fetch_data(link):
    res = requests.get(link)
    soup = BeautifulSoup(res.text, 'html.parser')
    print('pass')
    return str(soup.find('div', id='tresc'))

from concurrent.futures import ThreadPoolExecutor
from tqdm import tqdm

with ThreadPoolExecutor(max_workers=15) as executor:
    results = list(tqdm(executor.map(fetch_data, all_links), total=len(all_links)))

all_data.extend(results)

all_data.extend(results)
len(all_data)
pd.DataFrame(all_data).to_csv('all_data.csv',index=False)
pd.read_csv('all_data.csv')
for i, link in enumerate(all_links):
    print(f'{i}/{len(all_links)}')

res=requests.get(all_links[1])
soup=BeautifulSoup(res.text,'html.parser')

all_data.append(str(soup.find('div',id='tresc')))

html=''
for data in all_data:
    html+=data
all_data[3]
with open('all_data.html','w',encoding='utf8') as f:
    f.write(html)



def parse_entry(html_entry):
    soup = BeautifulSoup(html_entry, 'html.parser')
    
    # Extracting fields from HTML
    data = {
        "Title": soup.find("h1").text if soup.find("h1") else None,
        "Manifest": soup.find("div", class_="row").text.strip() if soup.find("div", class_="row") else None,
        "Archive": None,
        "Fond": None,
        "Reference Number": None,
        "Language": None,
        "Creation Date": None,
        "Place of Origin": None,
        "Geographical Names": None,
        "Surnames": None,
        "Notes": None,
        "Tags": None
    }

    # Extract subsequent fields using `row` class
    for row in soup.find_all("div", class_="row"):
        text = row.get_text(separator=" ", strip=True)
        
        if "Archive:" in text:
            data["Archive"] = text.split(":")[1].strip()
        elif "Fond:" in text:
            data["Fond"] = text.split(":")[1].strip()
        elif "Reference Number:" in text:
            data["Reference Number"] = text.split(":")[1].strip()
        elif "Language:" in text:
            data["Language"] = text.split(":")[1].strip()
        elif "Creation Date:" in text:
            data["Creation Date"] = row.find("b").text.strip() if row.find("b") else None
        elif "Place of origin:" in text:
            data["Place of Origin"] = row.find("a").text.strip() if row.find("a") else None
        elif "Geographical names:" in text:
            data["Geographical Names"] = text.split(":")[1].strip()
        elif "Surnames:" in text:
            data["Surnames"] = ', '.join(a.text.strip() for a in row.find_all("a"))
        elif "Notes:" in text:
            data["Notes"] = row.find("p").text.strip() if row.find("p") else None

    # Extracting tags at the end
    tags = soup.find_all("a", class_="etykieta")
    data["Tags"] = ', '.join(tag.text.strip() for tag in tags)
    
    return data

# Parse all entries and create a DataFrame
parsed_data = [parse_entry(entry) for entry in all_data]
df = pd.DataFrame(parsed_data)
df.drop_duplicates(inplace=True)
# Save to CSV or display
df.to_csv('parsed_data.csv', index=False)