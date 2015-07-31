 # -*- encoding : utf-8 -*-
require "hashnest/version"
require "openssl"
require "net/http"
require "net/https"
require "uri"
require "json"
require "addressable/uri"

module Hashnest
  class API
    attr_accessor :api_key, :api_secret, :username, :nonce_v

    def initialize(username, api_key, api_secret)
      self.username = username
      self.api_key = api_key
      self.api_secret = api_secret
    end

    def api_call(method, param = {}, priv = false, action = '', method_type='post', is_json = true)
      url = "https://www.hashnest.com/api/v1/#{ method }/#{ action }"
      if priv
        self.nonce
        param.merge!(:access_key => self.api_key, :signature => self.signature.to_s, :nonce => self.nonce_v)
      end

      answer = self.send(method_type.to_sym, url, param)

      # unfortunately, the API does not always respond with JSON, so we must only
      # parse as JSON if is_json is true.
      if is_json
        JSON.parse(answer)
      else
        answer
      end
    end

    def nonce
      self.nonce_v = (Time.now.to_f * 1000).to_i.to_s
    end

    def signature
      str = self.nonce_v + self.username + self.api_key
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha256'), self.api_secret, str)
    end

    def account
      api_call("account", {}, true)
    end

    def currency_accounts
      api_call("currency_accounts", {}, true)
    end

    def hash_accounts
      api_call("hash_accounts", {}, true)      
    end

    def order_active currency_market_id
      api_call("orders", {currency_market_id: currency_market_id}, true, "active")
    end

    def order_history currency_market_id, page=1, page_per_amount=20
      api_call("orders", {currency_market_id: currency_market_id, page: page, page_per_amount: page_per_amount}, true, "history")
    end

    def trade currency_market_id, category, amount, ppc
      api_call("orders", {currency_market_id: currency_market_id, category: category, amount: amount, ppc: ppc}, true)
    end

    def revoke_order order_id
      api_call("orders", {order_id: order_id}, true, 'revoke')
    end

    def quick_revoke currency_market_id
      api_call("orders", {currency_market_id: currency_market_id}, true, "quick_revoke")
    end

    def currency_markets
      api_call("currency_markets", {}, true)
    end

    def currency_market_history currency_market_id
      api_call("currency_markets", {currency_market_id: currency_market_id}, true, 'order_history')
    end

    def currency_market_orders currency_market_id
      api_call("currency_markets", {currency_market_id: currency_market_id}, true, 'orders')
    end

    def get url, param
      url_path = url + "?#{param.map{|k,v| "#{k}=#{v}"}.join("&")}"
    end

    def post(url, param)
      uri = URI.parse(url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      params = Addressable::URI.new
      params.query_values = param
      https.post(uri.path, params.query).body
    end
  end
end
