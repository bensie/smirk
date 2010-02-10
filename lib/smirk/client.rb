module Smirk

  class Client
  
    API_KEY = "26Kw6kit9TBk2yFcYEwv2wWajATGYs1F"
    HOST = "api.smugmug.com/services/api/json/1.2.2/"
  
    def self.version
      '0.0.1'
    end
 
    def self.gem_version_string
      "smirk-gem/#{version}"
    end
  
    attr_reader :user, :password, :session_id
 
    def initialize(user, password)
      @user = user
      @password = password
      params = { :method => "smugmug.login.withPassword", :APIKey => API_KEY, :EmailAddress => user, :Password => password }
      @session_id = JSON.parse(get("https://#{HOST}/", params))['Login']['Session']['id']
    end
    
    def logout
      params = default_params.merge!(:method => "smugmug.logout")
      JSON.parse(get("http://#{host}/", params))
    end
    
    def albums
      params = default_params.merge!(:method => "smugmug.albums.get")
      json = JSON.parse(get("http://#{HOST}/", params))["Albums"]
      json.inject([]) do |albums, a|
        albums << Smirk::Album.new(a["id"], a["Key"], a["Title"], a["Category"]["id"], a["Category"]["Name"], session_id)
      end
    end
    
    private
  
    def get(uri, params = {})
      RestClient.post uri, params
    end
    
    def default_params
      { :APIKey => Smirk::Client::API_KEY, :SessionID => session_id }
    end
  end
end