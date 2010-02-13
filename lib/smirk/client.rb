module Smirk

  class Client
  
    API_KEY = "26Kw6kit9TBk2yFcYEwv2wWajATGYs1F"
    HOST = "api.smugmug.com/services/api/json/1.2.2/"
  
    attr_reader :session_id
 
    def initialize(user, password)
      @user = user
      @password = password
      params = { :method => "smugmug.login.withPassword", :APIKey => API_KEY, :EmailAddress => user, :Password => password }
      @session_id = get(params, true)['Login']['Session']['id']
    end
    
    def logout
      params = default_params.merge!(:method => "smugmug.logout")
      get(params)
    end
    
    def albums(heavy = false)
      params = default_params.merge!({:method => "smugmug.albums.get", :Heavy => heavy})
      json = get(params)["Albums"]
      json.inject([]) do |albums, a|
        albums << Smirk::Album.new(session_id, upper_hash_to_lower_hash(a))
      end
    end
    
    def categories
      params = default_params.merge!(:method => "smugmug.categories.get")
      json = get(params)["Categories"]
      json.inject([]) do |categories, c|
        categories << Smirk::Category.new(session_id, upper_hash_to_lower_hash(c))
      end
    end
    
    def find_album(id, key)
      params = default_params.merge!({:method => "smugmug.albums.getInfo", :AlbumID => id, :AlbumKey => key})
      a = get(params)["Album"]
      Smirk::Album.new(session_id, upper_hash_to_lower_hash(a))
    end
    
    def find_image(id, key)
      params = default_params.merge!({:method => "smugmug.images.getInfo", :ImageID => id, :ImageKey => key})
      i = get(params)["Image"]
      Smirk::Image.new(session_id, upper_hash_to_lower_hash(i))
    end
    
    private
  
    def get(params = {}, ssl = false)
      proto = ssl ? "https://" : "http://"
      JSON.parse(RestClient.post proto+HOST, params)
    end
    
    def default_params
      { :APIKey => API_KEY, :SessionID => session_id }
    end
    
    def upper_hash_to_lower_hash(upper)
      if Hash === upper
        lower = {}
        upper.each_pair do |key, value|
          lower[key.downcase.to_sym] = upper_hash_to_lower_hash(value)
        end
        lower
      else
        upper
      end
    end
    
  end
end