import requests

headers = {'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; '
  'x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36'}

main_url = "https://www.nseindia.com/"
response = requests.get(main_url, headers=headers)
#print(response.status_code)
cookies = response.cookies

new_url = 'https://www.nseindia.com/api/equity-stockIndices?index=NIFTY%2050'
bank_nifty_oi_data = requests.get(new_url, headers=headers, cookies=cookies)
dat = bank_nifty_oi_data.json()

dat1 = dat['data']

###

headers = {'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; '
  'x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36'}

main_url = "https://www.nseindia.com/"
response = requests.get(main_url, headers=headers)
#print(response.status_code)
cookies = response.cookies

new_url1 = 'https://www.nseindia.com/api/equity-stockIndices?index=SECURITIES%20IN%20F%26O'
bank_nifty_oi_data_1 = requests.get(new_url1, headers=headers, cookies=cookies)
dat2 = bank_nifty_oi_data_1.json()

dat2 = dat2['data']

