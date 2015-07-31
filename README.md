gem 'hashnest', :require => 'hashnest',git: 'git@github.com:yinchangxin/hashnest-api.git'

API file
========

Verification method
-------------------

```ruby
Param:
  access_key: API KEY is created in the users account page
  nonce: Nonce is a regular integer number in UTC Time
  signature: Signature is a HMAC-SHA256 encoded message containing: nonce, client ID and API key. The HMAC-SHA256 code must be generated using a secret key that was generated with your API key. You must use the HMAC-SHA256 that created by API key when you sign.
```

##### API key

To get an API key, go to "Finance", "Setting" Tab. Set permissions and click "Generate key".

##### Nonce

Nonce is a timestamp in integer, stands for milliseconds elapsed since Unix epoch. Nonce must be within 30 seconds of server's current time. Each nonce can only be used once.

##### Signature

Signature is a HMAC-SHA256 encoded message containing: nonce, client ID and API key. The HMAC-SHA256 code must be generated using a secret key that was generated with your API key. This code must be converted to it's hexadecimal representation (64 characters).
Example (Python):

```ruby
  message = nonce + username + access_key
  signature = hmac.new(secret_key, msg=message, digestmod=hashlib.sha256).hexdigest()
```

For example: To obtain all opened markets URL:

```ruby
https://www.hashnest.com/api/v1/currency_markets?access_key=PZMhwXRx75mNqGhl430mLUhqODzyhQSf1bAiB4Tf&nonce=1416974538344337&signature=e1e0051e8fe8aa681ca465567567aaff231f56db54d3d3fb7f49cbf17871097e
```

All APIs below need to be verified by this way.

Account Info
------------
### Query Account Info

```
HTTP METHOD: POST
HTTP URL: https://www.hashnest.com/api/v1/account
Param:
  access_key: (Details see the verification method)
  nonce: (Details see the verification method)
  signature: (Details see the verification method)

Return Result:
  {
    id: 12,
    email: xxx@bitmain.com,
    temp_access_token: xxxxxxxx
  }
```




Currency account API
--------------------

### Check users account balance

```
HTTP METHOD: POST
HTTP URL: https://www.hashnest.com/api/v1/currency_accounts
Param:
  access_key: (Details see the verification method）
  nonce: (Details see the verification method）
  signature: (Details see the verification method）

Return Result:
  [
    {
      currency: {
        code: "btc"
      },
      amount: "41.0449535",
      blocked: "0.0",
      total: "41.0449535"
    },
    {
      currency: {
        code: "ltc"
      },
      amount: "0.0",
      blocked: "0.0",
      total: "0.0"
    }
]
```

Hash rate account API
---------------------

### Check user's hash rate account balance

```
HTTP METHOD: POST
HTTP URL: https://www.hashnest.com/api/v1/hash_accounts
Param:
  access_key: (Details see the verification method）
  nonce: (Details see the verification method）
  signature: (Details see the verification method）

Return Result:
[
  {
    currency: {
      code: "AntS1"
    },
    amount: "0.0",
    blocked: "0.0",
    total: "0.0"
  },
  {
    currency: {
      code: "AntS2"
    },
    amount: "980.0",
    blocked: "0.0",
    total: "980.0"
  }
]

```

Trading order API
-----------------

### Check user's active entrust order

```
HTTP METHOD: POST
HTTP URL: https://www.hashnest.com/api/v1/orders/active
Param:
  access_key: (Details see the verification method）
  nonce: (Details see the verification method）
  signature: (Details see the verification method）
  currency_market_id(交易市场ID): 1...

Return Result:

[
  {
    id: 48544,  #uniquely identify
    category: "sale", #catagory of entrust order
    amount: "1000.0", #amount of entrust order
    ppc: "0.01", #unit price of entrust order
    created_at: "2014-12-09 01:00:25" #created time of entrust order
  }
]

```

### Check user's trading order

```
HTTP METHOD: POST
HTTP URL: https://www.hashnest.com/api/v1/orders/history
Param:
  access_key: (Details see the verification method）
  nonce: (Details see the verification method）
  signature: (Details see the verification method）
  currency_market_id: 1..
  page: （Optional, default first page）
  page_per_amount: (Optional, default 20 records)

Return Result:
[
  {
    ppc: "0.00001",
    amount: "4.0",
    total_price: "0.00004",
    created_at: "2014-12-09 01:06:00"
  }
]

```

### Create an entrust order

```
HTTP METHOD： POST
HTTP URL: https://www.hashnest.com/api/v1/orders
Param:
  access_key: (Details see the verification method）
  nonce: (Details see the verification method）
  signature: (Details see the verification method)
  currency_market_id: (Market ID)
  amount: (amount of entrust order)
  ppc: (unit price of entrust order)
  category: (entrust type eg: [sale|purchase])

Return Result:
  Return to details of entrust order if successed
  eg:
  {
    id: 48544,  #uniquely identify
    category: "sale", #catagory of entrust order
    amount: "1000.0", #Amount of entrust order
    ppc: "0.01", #unit price of entrust order
    created_at: "2014-12-09 01:00:25" #created time of entrust order
  }
  Return to the faulty information if failed
  eg:


```

### cancel an entrust order

```
HTTP METHOD: POST
HTTP URL: https://www.hashnest.com/api/v1/orders/revoke
Param:
  access_key: (details see the verification method）
  nonce: (details see the verification method）
  signature: (details see the verification method）
  order_id:

Return Result:
{
  success: true|false
}

```

### cancel all entrust orders

```
HTTP METHOD: POST
HTTP URL: https://www.hashnest.com/api/v1/orders/quick_revoke
Param:
  access_key: (details see the verification method）
  nonce: (details see the verification method）
  signature: (details see the verification method）
  currency_market_id:

Return Result:
{
  success: true|false
}
```

Open market API
---------------

### obtain all opened markets

```
HTTP METHOD: POST
HTTP URL: https://www.hashnest.com/api/v1/currency_markets
Param:
  access_key: (details see the verification method）
  nonce: (details see the verification method）
  signature: (details see the verification method）

Return Result
[
  {
    id: 11,
    name: "ANTS2/BTC"
  }
]

```

### Obtain the trading order list on pointed market

```
HTTP METHOD: POST
HTTP URL: https://www.hashnest.com/api/v1/currency_markets/order_history
Param:
  access_key: (details see the verification method）
  nonce: (details see the verification method）
  signature: (details see the verification method）
  category: (entrust type eg: [sale|purchase])
  currency_market_id: (Market ID)

Return Result:
[
  {
    ppc: "0.00001",
    amount: "4.0",
    total_price: "0.00004",
    created_at: "2014-12-09 01:06:00"
  }
]

```
