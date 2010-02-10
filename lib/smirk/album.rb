module Smirk
  class Album < Client
    
    def initialize(session_id, info)
      info.each do |key, value|
        instance_variable_set("@#{key.downcase}", value)
        Album.instance_eval do
          attr_reader key.downcase.to_sym
        end
      end
      @session_id = session_id
    end
    
    def images
      params = default_params.merge!({:method => "smugmug.images.get", :AlbumID => id, :AlbumKey => key, :Heavy => true})
      json = get(params)["Album"]["Images"]
      json.inject([]) do |images, i|
        images << Smirk::Image.new(@session_id, i)
      end
    end
    
  end
end