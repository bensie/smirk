require 'rest_client'
require 'json'
 
# A Ruby class to call the SmugMug REST API.

module Smirk

  class Smirk::Client
  
    API_KEY = "26Kw6kit9TBk2yFcYEwv2wWajATGYs1F"
  
    def self.version
      '0.0.1'
    end
 
    def self.gem_version_string
      "smirk-gem/#{version}"
    end
  
    attr_reader :host, :user, :password, :session_id
 
    def initialize(user, password)
      @user = user
      @password = password
      @host = "api.smugmug.com/services/api/json/1.2.2/"
      params = { :method => "smugmug.login.withPassword", :APIKey => API_KEY, :EmailAddress => @user, :Password => @password }
      @session_id = JSON.parse(get("https://#{@host}/", params))['Login']['Session']['id']
    end
    
    def logout
      params = default_params.merge!(:method => "smugmug.logout")
      JSON.parse(get("http://#{@host}/", params))
    end
    
    def default_params
      { :APIKey => API_KEY, :SessionID => session_id }
    end
    
    # Albums
    def albums
      params = default_params.merge!(:method => "smugmug.albums.get")
      JSON.parse(get("http://#{@host}/", params))["Albums"]
    end
    
    private
  
    def get(uri, params = {})
      # POST requests are the only ones that accept parameters -- ick
      RestClient.post uri, params
    end
  end
end