
HashNest API integration. Ruby gem.

## Installation

Add this line to your application's Gemfile:

    gem 'hashnest'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hashnest



### Usage

####How to use?

####1. Create your ruby project

####2. Add "require 'hashnest'")

####3. Create class

```ruby
  api = Hashnest::API.new(username, key, secret)
```
```
username - your username on hashnest
key - your API key
secret - your API secret code
```

####4. Methods and parameters:


##Full API documentation: https://www.hashnest.com/hashnest_api


##Examples
Account Info
------------
### Query Account Info

```ruby
api = Hashnest::API.new(username, key, secret)
```

```ruby
puts api.account
```

```
Return Result:
  {
    id: 12,
    email: xxx@bitmain.com,
    temp_access_token: xxxxxxxx
  }
```

### Check users account balance

```ruby
puts api.currency_accounts
```

```
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


```ruby
puts api.hash_accounts
```

```
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

```ruby
puts api.order_active
```

```
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

```ruby
puts api.order_history currency_market_id, page=1, page_per_amount=20
```

```

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

```ruby
puts api.trade currency_market_id, category(sale|purchase), amount, ppc
```

```
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
```

### cancel an entrust order

```ruby
puts api.revoke_order order_id
```

```
Return Result:
{
  success: true|false
}

```

### cancel all entrust orders

```ruby
puts api.quick_revoke currency_market_id, category(sale|purchase)
```

```
Return Result:
{
  success: true|false
}
```

Open market API
---------------

### obtain all opened markets

```ruby
puts api.currency_markets
```

```
Return Result
[
  {
    id: 11,
    name: "ANTS2/BTC"
  }
]

```

### Obtain the trading order list on pointed market

```ruby
puts api.currency_market_history currency_market_id
```

```
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

### Market Depth

```ruby
puts api.currency_market_orders currency_market_id
```

```
Return Result:
{
  "purchase"=> [
    {"ppc"=>0.0013382, "category"=>"purchase", "amount"=>85}
  ], 
  "sale"=> [
    {"ppc"=>0.0199, "category"=>"sale", "amount"=>88}
  ]
}

```

