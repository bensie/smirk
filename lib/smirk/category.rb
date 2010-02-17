module Smirk
  class Category < Client
    
    def initialize(session_id, info)
      info.each do |key, value|
        instance_variable_set("@#{key}", value)
        Category.instance_eval do
          attr_reader key.to_sym
        end
      end
      @session_id = session_id
    end
    
  end
end