module Smirk
  class Album < Client
    
    def initialize(session_id, info)
      info.each do |key, value|
        instance_variable_set("@#{key}", value)
        Album.instance_eval do
          attr_reader key.to_sym
        end
      end
      @session_id = session_id
    end
    
    def images(heavy = false)
      params = default_params.merge!({:method => "smugmug.images.get", :AlbumID => id, :AlbumKey => key, :Heavy => heavy})
      json = get(params)["Album"]["Images"]
      json.inject([]) do |images, i|
        images << Smirk::Image.new(@session_id, upper_hash_to_lower_hash(i))
      end
    end
    
  end
end