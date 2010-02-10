module Smirk

  class Client
  
    API_KEY = "26Kw6kit9TBk2yFcYEwv2wWajATGYs1F"
    HOST = "api.smugmug.com/services/api/json/1.2.2/"
  
    def self.version
      '0.0.2'
    end
 
    def self.gem_version_string
      "smirk-gem/#{version}"
    end
  
    attr_reader :user, :password, :session_id
 
    def initialize(user, password)
      @user = user
      @password = password
      params = { :method => "smugmug.login.withPassword", :APIKey => API_KEY, :EmailAddress => user, :Password => password }
      @session_id = get(HOST, params, true)['Login']['Session']['id']
    end
    
    def logout
      params = default_params.merge!(:method => "smugmug.logout")
      get(HOST, params)
    end
    
    def albums
      params = default_params.merge!(:method => "smugmug.albums.get")
      json = get(HOST, params)["Albums"]
      json.inject([]) do |albums, a|
        albums << Smirk::Album.new(a["id"], a["Key"], a["Title"], a["Category"]["id"], a["Category"]["Name"], session_id)
      end
    end
    
    private
  
    def get(uri, params = {}, ssl = false)
      proto = ssl ? "https://" : "http://"
      JSON.parse(RestClient.post proto+uri, params)
    end
    
    def default_params
      { :APIKey => Smirk::Client::API_KEY, :SessionID => session_id }
    end
  end
end