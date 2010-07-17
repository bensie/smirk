module Smirk
  class Album < Client
    
    def initialize(info)
      info.each do |key, value|
        instance_variable_set("@#{key}", value)
        Album.instance_eval do
          attr_reader key.to_sym
        end
      end
    end
    
    def images(heavy = false)
      params = default_params.merge!({:method => "smugmug.images.get", :AlbumID => id, :AlbumKey => key, :Heavy => heavy})
      json = get(params)["Album"]["Images"]
      json.inject([]) do |images, i|
        images << Smirk::Image.new(upper_hash_to_lower_hash(i))
      end
    end
    
  end
end