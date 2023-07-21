import requests
import pandas as pd
import json

data=[]
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36',}
with requests.session() as req:
  req.get("https://www.nseindia.com/api/equity-stockIndices?index=SECURITIES%20IN%20F%26O",headers = headers)
  
api_req1 = req.get('https://www.nseindia.com/api/equity-stockIndices?index=SECURITIES%20IN%20F%26O',headers = headers).json()
df1 =  api_req1["data"]
nlive = pd.DataFrame(df1)


data=[]
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36',}
with requests.session() as req:
  req.get("https://www.nseindia.com/api/equity-stockIndices?index=NIFTY%2050",headers = headers)
  
api_req2 = req.get('https://www.nseindia.com/api/equity-stockIndices?index=NIFTY%2050',headers = headers).json()
df2 =  api_req2["data"]
nlive2 = pd.DataFrame(df2)


