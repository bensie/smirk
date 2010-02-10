module Smirk
  class Image < Client
    
    attr_reader :id, :key, :session_id
    
    def initialize(id, key, session_id)
      @id = id
      @key = key
      @session_id = session_id
    end
    
  end
end