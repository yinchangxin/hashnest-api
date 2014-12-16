 # -*- encoding : utf-8 -*-
require "hash_nest/version"
require "openssl"
require "net/http"
require "net/https"
require "uri"
require "json"
require "addressable/uri"
require 'rest-client'

module HashNest

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
      self.nonce_v = (Time.now.to_f * 1000000).to_i.to_s
    end

    def signature
      str = self.nonce_v + self.username + self.api_key
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha256'), self.api_secret, str)
    end

    def get url, param
      url_path = url + "?#{param.map{|k,v| "#{k}=#{v}"}.join("&")}"
    end

    def post(url, param)
      RestClient.post(url, param)
    end
  end
end
