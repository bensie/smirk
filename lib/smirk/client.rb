module Smirk

  class Client
  
    API_KEY = "26Kw6kit9TBk2yFcYEwv2wWajATGYs1F"
    HOST = "api.smugmug.com/services/api/json/1.2.2/"
  
    attr_reader :session_id
 
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
        albums << Smirk::Album.new(session_id, a)
      end
    end
    
    def categories
      params = default_params.merge!(:method => "smugmug.categories.get")
      json = get(HOST, params)["Categories"]
      json.inject([]) do |categories, c|
        categories << Smirk::Category.new(session_id, c)
      end
    end
    
    def find_album(id, key)
      params = default_params.merge!({:method => "smugmug.albums.getInfo", :AlbumID => id, :AlbumKey => key})
      a = get(HOST, params)["Album"]
      Smirk::Album.new(session_id, a)
    end
    
    def find_image(id, key)
      params = default_params.merge!({:method => "smugmug.images.getInfo", :ImageID => id, :ImageKey => key})
      i = get(HOST, params)["Image"]
      Smirk::Image.new(session_id, i)
    end
    
    private
  
    def get(uri, params = {}, ssl = false)
      proto = ssl ? "https://" : "http://"
      JSON.parse(RestClient.post proto+uri, params)
    end
    
    def default_params
      { :APIKey => API_KEY, :SessionID => session_id }
    end
  end
end