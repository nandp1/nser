
import requests

headers = {'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; '
  'x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36'}

main_url = "https://www.nseindia.com/"
response = requests.get(main_url, headers=headers)
#print(response.status_code)
cookies = response.cookies

new_url4 = 'https://www.nseindia.com/api/allIndices'
bank_nifty_oi_data_4 = requests.get(new_url4, headers=headers, cookies=cookies)
dat4 = bank_nifty_oi_data_4.json()

dat4 = dat4['data']


