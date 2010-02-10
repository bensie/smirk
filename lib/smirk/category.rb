module Smirk
  class Category < Client
    
    attr_reader :id, :name, :nice_name, :kind, :session_id
    
    def initialize(id, name, nice_name, kind, session_id)
      @id = id
      @name = name
      @nice_name = nice_name
      @kind = kind
      @session_id = session_id
    end
    
  end
end