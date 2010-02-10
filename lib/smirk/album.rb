module Smirk
  class Album < Client
    
    attr_reader :id, :key, :title, :category_id, :category_name, :session_id
    
    def initialize(id, key, title, category_id, category_name, session_id)
      @id = id
      @key = key
      @title = title
      @category_id = category_id
      @category_name = category_name
      @session_id = session_id
    end
    
    def images
      params = default_params.merge!({:method => "smugmug.images.get", :AlbumID => id, :AlbumKey => key})
      json = get(HOST, params)["Album"]["Images"]
      json.inject([]) do |images, i|
        images << Smirk::Image.new(i["id"], i["Key"], session_id)
      end
    end
    
  end
end