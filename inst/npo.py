
import requests

headers = {'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; '
  'x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36'}

main_url = "https://www.nseindia.com/"
response = requests.get(main_url, headers=headers)
#print(response.status_code)
cookies = response.cookies

new_url = 'https://www.nseindia.com/api/market-data-pre-open?key=FO'
bank_nifty_oi_data = requests.get(new_url, headers=headers, cookies=cookies)
dat = bank_nifty_oi_data.json()

dat1 = dat['data']


#good
headers = {'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; '
  'x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36'}

main_url = "https://www.nseindia.com/"
response = requests.get(main_url, headers=headers)
#print(response.status_code)
cookies = response.cookies

new_url1 = 'https://www.nseindia.com/api/market-data-pre-open?key=NIFTY'
bank_nifty_oi_data_1 = requests.get(new_url1, headers=headers, cookies=cookies)
dat2 = bank_nifty_oi_data_1.json()

dat2 = dat2['data']



headers = {'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; '
  'x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36'}

main_url = "https://www.nseindia.com/"
response = requests.get(main_url, headers=headers)
#print(response.status_code)
cookies = response.cookies

new_url2 = 'https://www.nseindia.com/api/market-data-pre-open?key=ALL'
bank_nifty_oi_data_2 = requests.get(new_url2, headers=headers, cookies=cookies)
dat3 = bank_nifty_oi_data_2.json()

dat3 = dat3['data']
