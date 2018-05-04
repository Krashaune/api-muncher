require 'httparty'
require 'pry'
require 'will_paginate'

class EdamamApiWrapper
  TOKEN_APP_ID = ENV['APP_ID']
  TOKEN_APP_KEY= ENV['APP_KEY']
  BASE_URL = "https://api.edamam.com/search"

  def self.list_all_recipes(search)
    url =  (BASE_URL+"?q="+search+"&app_id="+TOKEN_APP_ID+"&app_key="+TOKEN_APP_KEY+"&from=0&to=40")
    response = HTTParty.get(url)

    return response['hits'].map do |raw_data|
        Recipe.from_api(raw_data)
    end
  end

  def self.get_recipe(uri)
    encoded_uri = URI.encode(uri)
    url =  (BASE_URL+"?r=#{encoded_uri}&app_id="+TOKEN_APP_ID+"&app_key="+TOKEN_APP_KEY)
  end

end
