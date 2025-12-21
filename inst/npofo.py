
import requests

headers = {'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; '
  'x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36'}

main_url = "https://www.nseindia.com/"
response = requests.get(main_url, headers=headers)
#print(response.status_code)
cookies = response.cookies

new_url = 'https://www.nseindia.com/api/market-data-pre-open-fno?key=FUTSTK'
npo_fo = requests.get(new_url, headers=headers, cookies=cookies)
dat = npo_fo.json()

dat1 = dat['data']
